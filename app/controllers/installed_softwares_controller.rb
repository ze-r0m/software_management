class InstalledSoftwaresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_installed_software, only: %i[ show edit update destroy soft_delete restore ]
  after_action  :verify_policy_scoped, only: :index
  after_action  :verify_authorized,     except: :index

  # GET /installed_softwares or /installed_softwares.json
  def index
    @q = policy_scope(InstalledSoftware).ransack(params[:q])

    @installed_software = @q.result(distinct: true)
                            .includes(:comp_classes)
                            .page(params[:page])
                            .per(per_page)
    @current_per_page = per_page

    # Применяем ручной фильтр ПОСЛЕ Ransack
    if params.dig(:q, :finish_date).present?
      case params[:q][:finish_date]
      when 'this_month'
        @installed_software = @installed_software.where(finish_date: Time.current.beginning_of_month..Time.current.end_of_month)
      when 'this_year'
        @installed_software = @installed_software.where(finish_date: Time.current.beginning_of_year..Time.current.end_of_year)
      when 'today'
        @installed_software = @installed_software.where(finish_date: Date.current)
      when 'permanent'
        @installed_software = @installed_software.where(finish_date: nil)
      when 'expired'
        @installed_software = @installed_software.where("finish_date < ?", Date.current)
      end
    end

    @installed_software = @installed_software.includes(:comp_classes).page(params[:page]).per(per_page)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /installed_softwares/1 or /installed_softwares/1.json
  def show
    authorize @installed_software
    if @installed_software.deleted_at.present? && !current_user.role.name == 'moderator'
      redirect_to installed_software_path, alert: 'ПО недоступно'
    end
  end

  # GET /installed_softwares/new
  def new
    @installed_software = InstalledSoftware.new
    authorize @installed_software
  end

  # GET /installed_softwares/1/edit
  def edit
    authorize @installed_software
  end

  # POST /installed_softwares or /installed_softwares.json
  def create
    @installed_software = InstalledSoftware.new(installed_software_params)
    @installed_software.perpetual_flag = params[:is_perpetual] == '1'
    @installed_software.finish_date = nil if @installed_software.perpetual_flag

    authorize @installed_software

    respond_to do |format|
      if @installed_software.save
        format.html { redirect_to @installed_software, notice: t('flash.actions.create.notice', model: InstalledSoftware.model_name.human) }
        format.json { render :show, status: :created, location: @installed_software }
      else
        flash.now[:alert] = @installed_software.errors.full_messages.join("<br>").html_safe
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @installed_software.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /installed_softwares/1 or /installed_softwares/1.json
  def update
    @installed_software.perpetual_flag = params[:is_perpetual] == '1'
    @installed_software.finish_date = nil if @installed_software.perpetual_flag

    authorize @installed_software
    respond_to do |format|
      if @installed_software.update(installed_software_params)
        format.html { redirect_to @installed_software, notice: t('flash.actions.update.notice', model: InstalledSoftware.model_name.human) }
        format.json { render :show, status: :ok, location: @installed_software }
      else
        flash.now[:alert] = @installed_software.errors.full_messages.join("<br>").html_safe
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @installed_software.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /installed_softwares/1 or /installed_softwares/1.json
  def destroy
    authorize @installed_software
    @installed_software.destroy!

    respond_to do |format|
      format.html { redirect_to installed_softwares_path, status: :see_other, notice: t('flash.actions.destroy.notice', model: InstalledSoftware.model_name.human) }
      format.json { head :no_content }
    end
  end

  def soft_delete
    authorize @installed_software, :soft_delete?

    @installed_software.soft_delete!

    respond_to do |format|
      format.js
      format.html { redirect_back fallback_location: installed_softwares_path, alert: 'ПО помечено на удаление' }
    end
  end

  def restore
    authorize @installed_software, :restore?
    @installed_software.update(deleted_at: nil)

    respond_to do |format|
      format.js
      format.html { redirect_back fallback_location: installed_softwares_path, notice: 'ПО восстановлено' }
    end
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    redirect_to installed_softwares_path, alert: 'Запись не найдена или была удалена'
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_installed_software
      @installed_software = InstalledSoftware.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def installed_software_params
    params[:installed_software][:comp_class_ids].reject!(&:blank?) if params[:installed_software][:comp_class_ids]

    params.require(:installed_software).permit(
      :name, :note, :version, :is_server,
      :start_date, :finish_date, :key_holder,
      :quantity, :usage_basis, purpose: [],
      comp_class_ids: []
    )
  end
end
