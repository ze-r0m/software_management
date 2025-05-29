class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :check_user_permission, only: [:edit, :update]
  after_action  :verify_policy_scoped, only: :index
  after_action  :verify_authorized,     except: :index

  # GET /users or /users.json
  def index
    @flash = []
    clean_query = params[:q] ||= {}

    # Валидация логина (минимум 2 символа)
    if clean_query[:username_cont].present? && clean_query[:username_cont].length < 2
      @flash << "Логин должен содержать не менее 2 символов"
      clean_query[:username_cont] = nil
    end

    # Валидация email (если есть, должен быть в валидном формате)
    if clean_query[:email_cont].present?
      unless clean_query[:email_cont] =~ URI::MailTo::EMAIL_REGEXP
        @flash << "Неверный формат email"
        clean_query[:email_cont] = nil
      end
    end

    # Валидация роли (если передана, должна быть ID существующей роли)
    if clean_query[:role_id_eq].present?
      unless Role.exists?(id: clean_query[:role_id_eq])
        @flash << "Выбранная роль не существует"
        clean_query[:role_id_eq] = nil
      end
    end

    # Валидация количества входов
    if clean_query[:sign_in_count_gteq].present?
      count = clean_query[:sign_in_count_gteq]
      unless count.to_s =~ /\A\d+\z/
        @flash << "Количество входов должно быть числом"
        clean_query[:sign_in_count_gteq] = nil
      end
    end

    # Валидация IP-адреса
    if clean_query[:current_sign_in_ip_cont].present?
      unless clean_query[:current_sign_in_ip_cont] =~ /\A(\d{1,3}\.){3}\d{1,3}\z/
        @flash << "IP должен быть в формате IPv4 (например, 192.168.1.1)"
        clean_query[:current_sign_in_ip_cont] = nil
      end
    end

    # Валидация и преобразование дат
    begin
      if clean_query[:created_at_eq].present?
        date = Date.parse(clean_query[:created_at_eq])
        clean_query[:created_at_gteq] = date.beginning_of_day
        clean_query[:created_at_lteq] = date.end_of_day
        clean_query.delete(:created_at_eq)
      end
    rescue ArgumentError
      @flash << "Некорректная дата регистрации"
      clean_query.delete(:created_at_eq)
    end

    begin
      if clean_query[:current_sign_in_at_eq].present?
        date = Date.parse(clean_query[:current_sign_in_at_eq])
        clean_query[:current_sign_in_at_gteq] = date.beginning_of_day
        clean_query[:current_sign_in_at_lteq] = date.end_of_day
        clean_query.delete(:current_sign_in_at_eq)
      end
    rescue ArgumentError
      @flash << "Некорректная дата последнего входа"
      clean_query.delete(:current_sign_in_at_eq)
    end

    flash.now[:alert] = @flash.join('<br>').html_safe if @flash.any?

    @q = policy_scope(User).includes(:role).ransack(clean_query)
    @users = @q.result
               .includes(:role)
               .order(:email)
               .page(params[:page])
               .per(per_page)

    @current_per_page = per_page

    respond_to do |format|
      format.html
      format.js
    end
  end



  # GET /users/1 or /users/1.json
  def show
    authorize @user
  end

  # GET /profile
  def profile
    @user = current_user
    authorize @user, :show? # можешь использовать отдельный метод, если хочешь ограничить доступ
    render :profile
  end

  # GET /users/new
  def new
    @user = User.new
    authorize @user
  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    authorize @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    authorize @user

    # Начинаем с параметров пользователя
    filtered_params = user_params

    # Если пользователь хочет сменить пароль
    if params[:user][:change_password] == '1'
      # Проверка текущего пароля, если редактирует сам себя
      if current_user == @user
        unless @user.valid_password?(params[:user][:current_password])
          @user.errors.add(:current_password, 'Неверный текущий пароль')
          return render :edit, status: :unprocessable_entity
        end
      end
    else
      # Если смена пароля не запрошена, убираем password-поля
      filtered_params = filtered_params.except(:password, :password_confirmation)
    end

    respond_to do |format|
      if @user.update(filtered_params)
        target_path = current_user == @user ? profile_path : user_path(@user)
        format.html { redirect_to target_path, notice: 'Пользователь успешно обновлён.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /users/1 or /users/1.json
  def destroy
    authorize @user
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = params[:id] ? User.find(params[:id]) : current_user
    end

  def check_user_permission
    # Модератор или сам пользователь может редактировать только свой профиль
    if current_user.role.name == 'moderator' && current_user != @user
      redirect_to root_path, alert: "У вас нет прав для редактирования этого пользователя."
    end
  end
  def user_params
    # базовые поля
    allowed = [:email, :username, :role_id]
    allowed << :role_id if current_user&.role&.name == 'admin'
    # при создании или если отметил смену пароля — разрешаем пароли
    if action_name == 'create' || params.dig(:user, :change_password) == '1'
      allowed += [:password, :password_confirmation]
    end
    params.require(:user).permit(allowed)
  end

end
