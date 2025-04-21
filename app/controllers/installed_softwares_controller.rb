class InstalledSoftwaresController < ApplicationController
  before_action :set_installed_software, only: %i[ show edit update destroy ]

  # GET /installed_softwares or /installed_softwares.json
  def index
    @q = InstalledSoftware.ransack(params[:q])

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
  end

  # GET /installed_softwares/new
  def new
    @installed_software = InstalledSoftware.new
  end

  # GET /installed_softwares/1/edit
  def edit
  end

  # POST /installed_softwares or /installed_softwares.json
  def create
    @installed_software = InstalledSoftware.new(installed_software_params)

    respond_to do |format|
      if @installed_software.save
        format.html { redirect_to @installed_software, notice: "Installed software was successfully created." }
        format.json { render :show, status: :created, location: @installed_software }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @installed_software.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /installed_softwares/1 or /installed_softwares/1.json
  def update
    respond_to do |format|
      if @installed_software.update(installed_software_params)
        format.html { redirect_to @installed_software, notice: "Installed software was successfully updated." }
        format.json { render :show, status: :ok, location: @installed_software }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @installed_software.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /installed_softwares/1 or /installed_softwares/1.json
  def destroy
    @installed_software.destroy!

    respond_to do |format|
      format.html { redirect_to installed_softwares_path, status: :see_other, notice: "Installed software was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_installed_software
      @installed_software = InstalledSoftware.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def installed_software_params
      params.require(:installed_software).permit(:name, :version, :start_date, :finish_date, comp_class_ids:[])
    end
end
