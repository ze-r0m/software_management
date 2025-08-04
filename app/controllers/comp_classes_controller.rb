class CompClassesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comp_class, only: %i[ show edit update destroy soft_delete restore ]
  after_action  :verify_policy_scoped, only: :index
  after_action  :verify_authorized,     except: :index

  # GET /comp_classes or /comp_classes.json
  def index
    @q = policy_scope(CompClass).includes(:cafedra).ransack(params[:q])
    all_filtered = @q.result(distinct: true)

    @comp_classes = all_filtered.page(params[:page]).per(per_page)
    @current_per_page = per_page

    @comp_classes_aud_number_in = all_filtered.pluck(:aud_number).uniq
    @all_aud_numbers = CompClass.not_deleted.order(:aud_number).distinct.pluck(:aud_number)
    @cafedras = Cafedra.order(:name)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /comp_classes/1 or /comp_classes/1.json
  def show
    authorize @comp_class
    if @comp_class.deleted_at.present? && !current_user.role.name == 'moderator'
      redirect_to comp_classes_path, alert: 'Аудитория недоступна'
    end
  end

  # GET /comp_classes/new
  def new
    @comp_class = CompClass.new
    authorize @comp_class
  end

  # GET /comp_classes/1/edit
  def edit
    authorize @comp_class
  end

  # POST /comp_classes or /comp_classes.json
  def create
    @comp_class = CompClass.new(comp_class_params)
    authorize @comp_class

    respond_to do |format|
      if @comp_class.save
        format.html { redirect_to @comp_class, notice: t('flash.actions.create.notice', model: CompClass.model_name.human) }
        format.json { render :show, status: :created, location: @comp_class }
      else
        flash.now[:alert] = @comp_class.errors.full_messages.join("<br>").html_safe
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comp_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comp_classes/1 or /comp_classes/1.json
  def update
    authorize @comp_class
    respond_to do |format|
      if @comp_class.update(comp_class_params)
        format.html { redirect_to @comp_class, notice: t('flash.actions.update.notice', model: CompClass.model_name.human) }
        format.json { render :show, status: :ok, location: @comp_class }
      else
        flash.now[:alert] = @comp_class.errors.full_messages.join("<br>").html_safe
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comp_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comp_classes/1 or /comp_classes/1.json
  def destroy
    authorize @comp_class
    @comp_class.destroy!

    respond_to do |format|
      format.html { redirect_to comp_classes_path, status: :see_other, notice: t('flash.actions.destroy.notice', model: CompClass.model_name.human) }
      format.json { head :no_content }
    end
  end

  def soft_delete
    authorize @comp_class, :soft_delete?

    @comp_class.soft_delete!

    respond_to do |format|
      format.js   # soft_delete.js.erb
      format.html { redirect_back fallback_location: comp_classes_path, alert: 'Аудитория помечена на удаление' }
    end
  end

  def restore
    authorize @comp_class, :restore?
    @comp_class.update(deleted_at: nil)

    respond_to do |format|
      format.js   # render restore.js.erb
      format.html { redirect_back fallback_location: comp_classes_path, notice: 'Аудитория восстановлена' }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comp_class
      @comp_class = CompClass.find(params.fetch(:id))
    end

    # Only allow a list of trusted parameters through.
    def comp_class_params
      params.require(:comp_class).permit(
        :aud_number, :count_seat, :count_comp_seat,
        :count_comp, :spec_purpose, :projector, :panel,
        :ch_board, :description, :cafedra_id
      )
    end
end
