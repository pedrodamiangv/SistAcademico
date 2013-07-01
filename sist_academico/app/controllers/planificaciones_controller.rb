require 'custom_logger'
class PlanificacionesController < ApplicationController
  before_filter :require_login
  #before_filter :correct_user_is_docente,  only: [:new, :create] || :admin_user
  before_filter :correct_user,   only: [:edit, :update, :show] || :admin_user

  # GET /planificaciones
  # GET /planificaciones.json
  def index
    @planificaciones = Planificacion.order('created_at DESC').all

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
        redirect_to @materia, notice: 'La planificacion se ha guardado con exito '
        CustomLogger.info("Una nueva tarea: #{@planificacion.tarea.inspect}, Etapa: #{@planificacion.etapa.inspect}, Fecha de Entrega: #{@planificacion.fecha_entrega.inspect} ,Total de Puntos: #{@planificacion.total_puntos.inspect} ,Descripcion: #{@planificacion.descripcion.inspect} correspondiente a la materia: #{@planificacion.materia_materia.inspect} ha sido creada por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      else
        flash[:error] = 'No pudo guardarse la tarea. ' 
        CustomLogger.error("No pudo registrarse la tarea: #{@planificacion.tarea.inspect} y sus demas atributos por el usuario: #{current_user.full_name.inspect} ,#{Time.now}")
        redirect_to @materia
      end
    end
  end

  # PUT /planificaciones/1
  # PUT /planificaciones/1.json
  def update
    @planificacion = Planificacion.find(params[:id])
    tarea_antigua = @planificacion.tarea
    etapa_antigua = @planificacion.etapa
    fecha_entrega_antigua = @planificacion.fecha_entrega
    total_puntos_antiguo = @planificacion.total_puntos
    descripcion_antigua = @planificacion.descripcion

    respond_to do |format|
      if @planificacion.update_attributes(params[:planificacion])
        tarea_nueva = @planificacion.tarea
        etapa_nueva = @planificacion.etapa
        fecha_entrega_nueva = @planificacion.fecha_entrega
        total_puntos_nuevo = @planificacion.total_puntos
        descripcion_nueva = @planificacion.descripcion

        format.html { redirect_to @planificacion, notice: 'La planificacion ha sido actualizada con exito.' }
        CustomLogger.info("Los datos antes de ser actualizados son: tarea: #{tarea_antigua.inspect}, Etapa: #{etapa_antigua.inspect}, Fecha de Entrega: #{fecha_entrega_antigua.inspect} ,Total de Puntos: #{total_puntos_antiguo.inspect} ,Descripcion: #{descripcion_antigua.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son los siguientes: Tarea: #{tarea_nueva.inspect}, Etapa: #{etapa_nueva.inspect}, Fecha de Entrega: #{fecha_entrega_nueva.inspect} ,Total de Puntos: #{total_puntos_nuevo.inspect} ,Descripcion: #{descripcion_nueva.inspect}, #{Time.now}")
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
    @destruyo = false
    respond_to do |format|
      begin
        if @planificacion.destroy
           @destruyo = true
        end
          notice = "La tarea y sus demas atributos han sido eliminados correctamente. "
          CustomLogger.info("Tarea: #{@planificacion.tarea.inspect}, Etapa: #{@planificacion.etapa.inspect}, Fecha de Entrega: #{@planificacion.fecha_entrega.inspect} ,Total de Puntos: #{@planificacion.total_puntos.inspect} ,Descripcion: #{@planificacion.descripcion.inspect} correspondiente a la materia: #{@planificacion.materia_materia.inspect} han sido eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      rescue
          notice = "Esta tarea no puede ser eliminada correctamente. "
          CustomLogger.error("Error al eliminar la tarea: #{@planificacion.tarea.inspect} y sus demas atributos por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      ensure
          format.html{ redirect_to @materia, notice: notice}
          format.json{ head :no_content}
          format.js
      end
    end
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
