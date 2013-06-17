class PlanificacionesController < ApplicationController
  before_filter :require_login
  #before_filter :correct_user_is_docente,  only: [:new, :create] || :admin_user
  before_filter :correct_user,   only: [:edit, :update, :show] || :admin_user

  # GET /planificaciones
  # GET /planificaciones.json
  def index
    @planificaciones = Planificacion.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @planificaciones }
    end
  end

  # GET /planificaciones/1
  # GET /planificaciones/1.json
  def show
    @planificacion = Planificacion.find(params[:id])
    if @planificacion.puntajes != nil
      @puntaje = @planificacion.puntajes
    else
      @puntaje = @planificacion.puntajes.build
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @planificacion }
    end
  end

  # GET /planificaciones/new
  # GET /planificaciones/new.json
  def new
     @materia = Materia.find(params[:id])
     @planificacion = @materia.build_planificacion
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @materia }
    end
  end

  # GET /planificaciones/1/edit
  def edit
    @planificacion = Planificacion.find(params[:id])
    if @planificacion.puntajes.count == 0
      @puntajes = []
      @planificacion.materia.curso.alumnos.each do |alumno|
        puntaje = @planificacion.puntajes.build
        puntaje.alumno = alumno
        @puntajes << puntaje
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /planificaciones
  # POST /planificaciones.json
  def create
    if params[:test_button]
      @materia = Materia.find(params[:materia_id])
      @planificacion = @materia.planificaciones.build(params[:planificacion])
      if @planificacion.save
        redirect_to @materia, notice: 'La planificacion se ha guardado. '
      else
        flash[:error] = 'No pudo guardarse la tarea. ' 
        redirect_to @materia
      end
    end
  end

  # PUT /planificaciones/1
  # PUT /planificaciones/1.json
  def update
    @planificacion = Planificacion.find(params[:id])

    respond_to do |format|
      if @planificacion.update_attributes(params[:planificacion])
        format.html { redirect_to @planificacion, notice: 'La planificacion ha sido actualizada.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @planificacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planificaciones/1
  # DELETE /planificaciones/1.json
  def destroy
    @planificacion = Planificacion.find(params[:id])
    @materia = @planificacion.materia
    @planificacion.destroy
    redirect_to @materia, notice: 'Tarea eliminada.'
  end

  private
    def correct_user
      @user = Planificacion.find(params[:id]).materia.docente.user
      redirect_to(root_path) unless (current_user == @user || current_user.is_administrativo?)
    end

    def correct_user_for_save materia
      @user = materia.docente.user
      redirect_to(root_path) unless (current_user == @user || current_user.is_administrativo?)
    end

    def correct_user_is_docente 
      redirect_to(root_path) unless current_user.is_docente?
    end
end
