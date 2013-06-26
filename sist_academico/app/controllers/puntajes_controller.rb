require 'custom_logger'
class PuntajesController < ApplicationController
  before_filter :require_login
  before_filter :admin_user
  # GET /puntajes
  # GET /puntajes.json
  def index
    @puntajes = Puntaje.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @puntajes }
    end
  end

  # GET /puntajes/1
  # GET /puntajes/1.json
  def show
    @puntaje = Puntaje.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @puntaje }
    end
  end

  # GET /puntajes/new
  # GET /puntajes/new.json
  def new
    @puntaje = Puntaje.new
    atributos
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @puntaje }
    end
  end

  # GET /puntajes/1/edit
  def edit
    @puntaje = Puntaje.find(params[:id])
    atributos
  end

  # POST /puntajes
  # POST /puntajes.json
  def create
    @puntaje = Puntaje.new(params[:puntaje])

    respond_to do |format|
      if @puntaje.save
        format.html { redirect_to @puntaje, notice: 'El puntaje ha sido registrado con exito. ' }
        CustomLogger.info("Un nuevo puntaje: #{@puntaje.puntaje.to_i.inspect} correspondiente a la tarea: #{@puntaje.planificacion_tarea.inspect} del alumno: #{@puntaje.alumno.user_full_name.inspect} , Descripcion:#{@puntaje.descripcion.inspect} ha sido registrado por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @puntaje, status: :created, location: @puntaje }
      else
        atributos
        format.html { render action: "new" }
        CustomLogger.error("Se ha producido un error al querer registrar el puntaje: #{@puntaje.puntaje.to_i.inspect} y sus demas atributos, por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @puntaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /puntajes/1
  # PUT /puntajes/1.json
  def update
    @puntaje = Puntaje.find(params[:id])
    puntaje_antiguo = @puntaje.puntaje
    descripcion_antigua = @puntaje.descripcion

    respond_to do |format|
      if @puntaje.update_attributes(params[:puntaje])
        puntaje_nuevo = @puntaje.puntaje
        descripcion_nuevo = @puntaje.descripcion

        CustomLogger.info("Los datos antes de actualizar son: Puntaje: #{puntaje_antiguo.to_i.inspect} con la descripcion: #{descripcion_antigua.inspect} .Los datos actualizados por el usuario #{current_user.full_name.inspect} son el nuevo puntaje: #{puntaje_nuevo.to_i.inspect} con la descripcion: #{descripcion_nuevo.inspect} ,#{Time.now}")
        format.html { redirect_to @puntaje, notice: 'El puntaje ha sido actualizado con exito. ' }
        format.json { head :no_content }
      else
        atributos
        format.html { render action: "edit" }
        format.json { render json: @puntaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /puntajes/1
  # DELETE /puntajes/1.json
  def destroy
    @puntaje = Puntaje.find(params[:id])
    respond_to do |format|
      begin
        @puntaje.destroy
        notice = "El puntaje y sus demas atributos han sido eliminado correctamente. "
        CustomLogger.info("Puntaje: #{@puntaje.puntaje.to_i.inspect} correspondiente a la tarea: #{@puntaje.planificacion_tarea.inspect} del alumno: #{@puntaje.alumno.user_full_name.inspect} , Descripcion:#{@puntaje.descripcion.inspect} han sido eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      rescue
        notice = "Este puntaje y sus demas atributos no pueden ser eliminados"
        CustomLogger.error("Error al eliminar el puntaje: #{@puntaje.puntaje.to_i.inspect} y sus demas atributos, por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      ensure
        format.html { redirect_to puntajes_url, notice: notice }
        format.json { head :no_content }
      end
    end
  end

  private
    def atributos
      @alumnos = Alumno.order('created_at desc').all
      @planificaciones = Planificacion.order('created_at desc').all
    end
end
