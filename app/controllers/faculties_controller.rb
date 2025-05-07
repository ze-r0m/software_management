class FacultiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_faculty, only: %i[ show edit update destroy ]
  after_action  :verify_policy_scoped, only: :index
  after_action  :verify_authorized,     except: :index

  # protect_from_forgery except: :index

  # GET /faculties or /faculties.json
  def index
    @q = policy_scope(Faculty).ransack(params[:q])
    @faculties = @q.result.page(params[:page]).per(per_page)

    @current_per_page = per_page

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /faculties/1 or /faculties/1.json
  def show
    authorize @faculty
  end

  # GET /faculties/new
  def new
    @faculty = Faculty.new
    authorize @faculty
  end

  # GET /faculties/1/edit
  def edit
    authorize @faculty
  end

  # POST /faculties or /faculties.json
  def create
    @faculty = Faculty.new(faculty_params)
    authorize @faculty

    respond_to do |format|
      if @faculty.save
        format.html { redirect_to @faculty, notice: t('flash.actions.create.notice', model: Faculty.model_name.human) }
        format.json { render :show, status: :created, location: @faculty }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /faculties/1 or /faculties/1.json
  def update
    authorize @faculty
    respond_to do |format|
      if @faculty.update(faculty_params)
        format.html { redirect_to @faculty, notice: t('flash.actions.update.notice', model: Faculty.model_name.human) }
        format.json { render :show, status: :ok, location: @faculty }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faculties/1 or /faculties/1.json
  def destroy
    authorize @faculty
    @faculty.destroy

    respond_to do |format|
      format.html { redirect_to faculties_path, status: :see_other, notice: t('flash.actions.destroy.notice', model: Faculty.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faculty
      @faculty = Faculty.find(params[:id])
    end

    def faculty_params
      params.require(:faculty).permit(
        :name, :add_note
      )
    end

end
