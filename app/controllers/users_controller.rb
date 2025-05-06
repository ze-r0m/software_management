class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :check_user_permission, only: [:edit, :update]
  after_action  :verify_policy_scoped, only: :index
  after_action  :verify_authorized,     except: :index

  # GET /users or /users.json
  def index
    @q = policy_scope(User).ransack(params[:q])
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
    authorize @user
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
