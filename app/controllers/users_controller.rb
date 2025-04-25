class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_user_permission, only: [:edit, :update]

  # GET /users or /users.json
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.includes(:role)
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
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

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
    # если пароль пустой — не перезаписываем его
    if user_params[:password].blank?
      params = user_params.except(:password, :password_confirmation)
      @user.update(params)
    else
      @user.update(user_params)
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
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
    # при создании или если админ отметил смену пароля — разрешаем пароли
    if @user.new_record? || params.dig(:user, :change_password) == '1'
      allowed += [:password, :password_confirmation]
    end
    params.require(:user).permit(allowed)
  end

end
