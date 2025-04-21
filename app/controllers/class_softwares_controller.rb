class ClassSoftwaresController < ApplicationController
  before_action :set_class_software, only: %i[ show edit update destroy ]

  # GET /class_softwares or /class_softwares.json
  def index
    @class_softwares = ClassSoftware.all
  end

  # GET /class_softwares/1 or /class_softwares/1.json
  def show
  end

  # GET /class_softwares/new
  def new
    @class_software = ClassSoftware.new
  end

  # GET /class_softwares/1/edit
  def edit
  end

  # POST /class_softwares or /class_softwares.json
  def create
    @class_software = ClassSoftware.new(class_software_params)

    respond_to do |format|
      if @class_software.save
        format.html { redirect_to @class_software, notice: "Class software was successfully created." }
        format.json { render :show, status: :created, location: @class_software }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @class_software.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /class_softwares/1 or /class_softwares/1.json
  def update
    respond_to do |format|
      if @class_software.update(class_software_params)
        format.html { redirect_to @class_software, notice: "Class software was successfully updated." }
        format.json { render :show, status: :ok, location: @class_software }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @class_software.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_softwares/1 or /class_softwares/1.json
  def destroy
    @class_software.destroy!

    respond_to do |format|
      format.html { redirect_to class_softwares_path, status: :see_other, notice: "Class software was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_software
      @class_software = ClassSoftware.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def class_software_params
      params.expect(class_software: [ :comp_class_id, :installed_software_id ])
    end
end
