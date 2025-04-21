class RequestSoftAudsController < ApplicationController
  before_action :set_request_soft_aud, only: %i[ show edit update destroy ]

  # GET /request_soft_auds or /request_soft_auds.json
  def index
    @request_soft_auds = RequestSoftAud.all
  end

  # GET /request_soft_auds/1 or /request_soft_auds/1.json
  def show
  end

  # GET /request_soft_auds/new
  def new
    @request_soft_aud = RequestSoftAud.new
  end

  # GET /request_soft_auds/1/edit
  def edit
  end

  # POST /request_soft_auds or /request_soft_auds.json
  def create
    @request_soft_aud = RequestSoftAud.new(request_soft_aud_params)

    respond_to do |format|
      if @request_soft_aud.save
        format.html { redirect_to @request_soft_aud, notice: "Request soft aud was successfully created." }
        format.json { render :show, status: :created, location: @request_soft_aud }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request_soft_aud.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_soft_auds/1 or /request_soft_auds/1.json
  def update
    respond_to do |format|
      if @request_soft_aud.update(request_soft_aud_params)
        format.html { redirect_to @request_soft_aud, notice: "Request soft aud was successfully updated." }
        format.json { render :show, status: :ok, location: @request_soft_aud }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request_soft_aud.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_soft_auds/1 or /request_soft_auds/1.json
  def destroy
    @request_soft_aud.destroy!

    respond_to do |format|
      format.html { redirect_to request_soft_auds_path, status: :see_other, notice: "Request soft aud was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_soft_aud
      @request_soft_aud = RequestSoftAud.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def request_soft_aud_params
      params.expect(request_soft_aud: [ :request_soft_id, :comp_class_id ])
    end
end
