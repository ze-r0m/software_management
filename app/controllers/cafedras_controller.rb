class CafedrasController < ApplicationController
  before_action :set_cafedra, only: %i[ show edit update destroy ]

  # GET /cafedras or /cafedras.json
  def index
    @q = Cafedra.includes(:faculty).ransack(params[:q]) # важно: includes
    @cafedras = @q.result.page(params[:page]).per(per_page)
    @current_per_page = per_page

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /cafedras/1 or /cafedras/1.json
  def show
  end

  # GET /cafedras/new
  def new
    @cafedra = Cafedra.new
  end

  # GET /cafedras/1/edit
  def edit
  end

  # POST /cafedras or /cafedras.json
  def create
    @cafedra = Cafedra.new(cafedra_params)

    respond_to do |format|
      if @cafedra.save
        format.html { redirect_to @cafedra, notice: "Cafedra was successfully created." }
        format.json { render :show, status: :created, location: @cafedra }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cafedra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cafedras/1 or /cafedras/1.json
  def update
    respond_to do |format|
      if @cafedra.update(cafedra_params)
        format.html { redirect_to @cafedra, notice: "Cafedra was successfully updated." }
        format.json { render :show, status: :ok, location: @cafedra }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cafedra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cafedras/1 or /cafedras/1.json
  def destroy
    @cafedra.destroy!

    respond_to do |format|
      format.html { redirect_to cafedras_path, status: :see_other, notice: "Cafedra was successfully destroyed." }
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
      params.require(:cafedra).permit(:name, :add_note, faculty_id: [])
    end
end