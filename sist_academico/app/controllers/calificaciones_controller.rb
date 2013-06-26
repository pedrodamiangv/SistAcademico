require 'custom_logger'
class CalificacionesController < ApplicationController
  before_filter :require_login
  before_filter :admin_user
  # GET /calificaciones
  # GET /calificaciones.json
  def index
    @calificaciones = Calificacion.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calificaciones }
    end
  end

  # GET /calificaciones/1
  # GET /calificaciones/1.json
  def show
    @calificacion = Calificacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calificacion }
    end
  end

  # GET /calificaciones/new
  # GET /calificaciones/new.json
  def new
    @calificacion = Calificacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calificacion }
    end
  end

  # GET /calificaciones/1/edit
  def edit
    @calificacion = Calificacion.find(params[:id])
  end

  # POST /calificaciones
  # POST /calificaciones.json
  def create
    @calificacion = Calificacion.new(params[:calificacion])

    respond_to do |format|
      if @calificacion.save
        format.html { redirect_to @calificacion, notice: 'La calificacion ha sido registrado con exito.' }
        CustomLogger.info("Se ha registrado una nueva calificacion: #{@calificacion.calificacion.inspect} ,Materia: #{@calificacion.materia_materia.inspect} ,Puntos Correctos: #{@calificacion.puntos_correctos.inspect} ,Total de Puntos: #{@calificacion.total_puntos.inspect} ,Etapa: #{@calificacion.etapa.inspect} creados por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @calificacion, status: :created, location: @calificacion }
      else
        format.html { render action: "new" }
        CustomLogger.error("Error al querer registrar una nueva calificacion: #{@calificacion.calificacion.inspect} y sus demas atributos, por el usuario: #{current_user.full_name.inspect}, #{Time.now} ")
        format.json { render json: @calificacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calificaciones/1
  # PUT /calificaciones/1.json
  def update
    @calificacion = Calificacion.find(params[:id])
    calificacion_antigua = @calificacion.calificacion
    materia_antigua = @calificacion.materia_materia
    puntos_correctos_antiguo = @calificacion.puntos_correctos
    total_puntos_antiguo = @calificacion.total_puntos
    etapa_antigua = @calificacion.etapa

    respond_to do |format|
      if @calificacion.update_attributes(params[:calificacion])
        calificacion_nueva = @calificacion.calificacion
        materia_nueva = @calificacion.materia_materia
        puntos_correctos_nueva = @calificacion.puntos_correctos
        total_puntos_nueva = @calificacion.total_puntos
        etapa_nueva = @calificacion.etapa
        CustomLogger.info("Los datos antes de ser actualizados son: calificacion: #{calificacion_antigua.inspect} ,Materia: #{materia_antigua.inspect} ,Puntos Correctos: #{puntos_correctos_antiguo.inspect} ,Total de Puntos: #{total_puntos_antiguo.inspect} ,Etapa: #{etapa_antigua.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son los siguientes: calificacion: #{calificacion_nueva.inspect} ,Materia: #{materia_nueva.inspect} ,Puntos Correctos: #{puntos_correctos_nueva.inspect} ,Total de Puntos: #{total_puntos_nueva.inspect} ,Etapa: #{etapa_nueva.inspect}, #{Time.now} ")
        format.html { redirect_to @calificacion, notice: 'La calificacion ha sido actualizado con exito. ' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @calificacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calificaciones/1
  # DELETE /calificaciones/1.json
  def destroy
    @calificacion = Calificacion.find(params[:id])
    respond_to do |format|
      begin
        @calificacion.destroy
        notice = "La calificacion y sus demas atributos son eliminados correctamente. "
        CustomLogger.info("Calificacion: #{@calificacion.calificacion.inspect} ,Materia: #{@calificacion.materia_materia.inspect} ,Puntos Correctos: #{@calificacion.puntos_correctos.inspect} ,Total de Puntos: #{@calificacion.total_puntos.inspect} ,Etapa: #{@calificacion.etapa.inspect} han sido eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      rescue
        notice = "Esta calificacion y sus demas atributos no pueden ser eliminados"
        CustomLogger.error("La calificacion: #{@calificacion.calificacion.inspect} y sus demas atributos no pueden ser eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      ensure
        format.html { redirect_to calificaciones_url, notice: notice }
        format.json { head :no_content }
      end
    end
  end

  private
    def correct_user
      @calificacion = Calificacion.find(params[:id])
      if current_user.is_docente?
        redirect_to(root_path) unless ( @calificacion.materia.docente == current_user.docente)
      elsif current_user.is_alumno?
        redirect_to(root_path) 
      else
       redirect_to(root_path) unless ( current_user.is_administrativo?)
     end
    end
end
