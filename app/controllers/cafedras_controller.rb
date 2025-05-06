class CafedrasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cafedra, only: %i[ show edit update destroy ]
  after_action  :verify_policy_scoped, only: :index
  after_action  :verify_authorized,     except: :index

  # GET /cafedras or /cafedras.json
  def index
    @q = policy_scope(Cafedra).includes(:faculty).ransack(params[:q])
    @cafedras = @q.result.page(params[:page]).per(per_page)
    @current_per_page = per_page

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
    authorize @cafedra
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
    authorize @cafedra
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
      params.require(:cafedra).permit(
        :name, :add_note, :faculty_id
      )
    end
end