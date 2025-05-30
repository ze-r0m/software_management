class CafedrasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cafedra, only: %i[ show edit update destroy ]
  after_action  :verify_policy_scoped, only: :index
  after_action  :verify_authorized,     except: :index

  # GET /cafedras or /cafedras.json
  def index
    # Загружаем список всех валидных факультетов
    allowed_faculties = Faculty.pluck(:name)

    # Очищаем params[:q][:faculty_name_in], оставляя только валидные имена факультетов
    if params[:q].present? && params[:q][:faculty_name_in].present?
      params[:q][:faculty_name_in] = Array(params[:q][:faculty_name_in]).select do |faculty_name|
        allowed_faculties.include?(faculty_name)
      end
    end

    @q = policy_scope(Cafedra).includes(:faculty).ransack(params[:q])
    @cafedras = @q.result.page(params[:page]).per(per_page)
    @current_per_page = per_page

    @faculties = Faculty.order(:name)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /cafedras/1 or /cafedras/1.json
  def show
    authorize @cafedra
  end

  # GET /cafedras/new
  def new
    @cafedra = Cafedra.new
    authorize @cafedra
  end

  # GET /cafedras/1/edit
  def edit
    authorize @cafedra
  end

  # POST /cafedras or /cafedras.json
  def create
    @cafedra = Cafedra.new(cafedra_params)
    authorize @cafedra

    respond_to do |format|
      if @cafedra.save
        format.html { redirect_to @cafedra, notice: t('flash.actions.create.notice', model: Cafedra.model_name.human) }
        format.json { render :show, status: :created, location: @cafedra }
      else
        flash.now[:alert] = @cafedra.errors.full_messages.join("<br>").html_safe
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cafedra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cafedras/1 or /cafedras/1.json
  def update
    authorize @cafedra
    respond_to do |format|
      if @cafedra.update(cafedra_params)
        format.html { redirect_to @cafedra, notice: t('flash.actions.update.notice', model: Cafedra.model_name.human) }
        format.json { render :show, status: :ok, location: @cafedra }
      else
        flash.now[:alert] = @cafedra.errors.full_messages.join("<br>").html_safe
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cafedra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cafedras/1 or /cafedras/1.json
  def destroy
    authorize @cafedra
    @cafedra.destroy!

    respond_to do |format|
      format.html { redirect_to cafedras_path, status: :see_other, notice: t('flash.actions.destroy.notice', model: Cafedra.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cafedra
      @cafedra = Cafedra.find(params.fetch(:id))
    end

    # Only allow a list of trusted parameters through.
    def cafedra_params
      params.require(:cafedra).permit(
        :name, :add_note, :faculty_id
      )
    end
end