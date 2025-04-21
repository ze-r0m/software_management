class RequestSoftsController < ApplicationController
  before_action :set_request_soft, only: %i[ show edit update destroy ]

  # GET /request_softs or /request_softs.json
  def index
    @request_softs = RequestSoft.all
  end

  # GET /request_softs/1 or /request_softs/1.json
  def show
  end

  # GET /request_softs/new
  def new
    @request_soft = RequestSoft.new
  end

  # GET /request_softs/1/edit
  def edit
  end

  # POST /request_softs or /request_softs.json
  def create
    @request_soft = RequestSoft.new(request_soft_params)

    respond_to do |format|
      if @request_soft.save
        format.html { redirect_to @request_soft, notice: "Request soft was successfully created." }
        format.json { render :show, status: :created, location: @request_soft }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request_soft.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_softs/1 or /request_softs/1.json
  def update
    respond_to do |format|
      if @request_soft.update(request_soft_params)
        format.html { redirect_to @request_soft, notice: "Request soft was successfully updated." }
        format.json { render :show, status: :ok, location: @request_soft }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request_soft.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_softs/1 or /request_softs/1.json
  def destroy
    @request_soft.destroy!

    respond_to do |format|
      format.html { redirect_to request_softs_path, status: :see_other, notice: "Request soft was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_soft
      @request_soft = RequestSoft.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def request_soft_params
      params.expect(request_soft: [ :soft_name, :version, :count, :price, :contact, :cafedra_id ])
    end
end
