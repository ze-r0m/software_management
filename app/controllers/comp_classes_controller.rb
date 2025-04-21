class CompClassesController < ApplicationController
  before_action :set_comp_class, only: %i[ show edit update destroy ]

  # GET /comp_classes or /comp_classes.json
  def index
    @q = CompClass.includes(:cafedra).ransack(params[:q])
    @comp_classes = @q.result.page(params[:page]).per(per_page)
    @current_per_page = per_page

    @all_filtered_comp_class_auds = @q.result(distinct: true).pluck(:aud_number)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /comp_classes/1 or /comp_classes/1.json
  def show
  end

  # GET /comp_classes/new
  def new
    @comp_class = CompClass.new
  end

  # GET /comp_classes/1/edit
  def edit
  end

  # POST /comp_classes or /comp_classes.json
  def create
    @comp_class = CompClass.new(comp_class_params)

    respond_to do |format|
      if @comp_class.save
        format.html { redirect_to @comp_class, notice: "Comp class was successfully created." }
        format.json { render :show, status: :created, location: @comp_class }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comp_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comp_classes/1 or /comp_classes/1.json
  def update
    respond_to do |format|
      if @comp_class.update(comp_class_params)
        format.html { redirect_to @comp_class, notice: "Comp class was successfully updated." }
        format.json { render :show, status: :ok, location: @comp_class }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comp_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comp_classes/1 or /comp_classes/1.json
  def destroy
    @comp_class.destroy!

    respond_to do |format|
      format.html { redirect_to comp_classes_path, status: :see_other, notice: "Comp class was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comp_class
      @comp_class = CompClass.find(params.fetch(:id))
    end

    # Only allow a list of trusted parameters through.
    def comp_class_params
      params.require(:comp_class).permit( :aud_number, :count_seat, :count_comp_seat, :count_comp, :spec_purpose, :projector, :panel, :ch_board, :add_note, :cafedra_id)
    end
end
