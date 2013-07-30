require 'custom_logger'
class ConfiguracionesController < ApplicationController
  # GET /configuraciones
  # GET /configuraciones.json
  def index
    @configuraciones = Configuracion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @configuraciones }
    end
  end

  # GET /configuraciones/1
  # GET /configuraciones/1.json
  def show
    @configuracion = Configuracion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @configuracion }
    end
  end

  # GET /configuraciones/new
  # GET /configuraciones/new.json
  def new
    @configuracion = Configuracion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @configuracion }
    end
  end

  # GET /configuraciones/1/edit
  def edit
    @configuracion = Configuracion.find(params[:id])
  end

  # POST /configuraciones
  # POST /configuraciones.json
  def create
    @configuracion = Configuracion.new(params[:configuracion])

    respond_to do |format|
      if @configuracion.save
        format.html { redirect_to @configuracion, notice: 'La configuracion ha sido actualizada correctamente' }
        format.json { render json: @configuracion, status: :created, location: @configuracion }
      else
        format.html { render action: "new" }
        format.json { render json: @configuracion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /configuraciones/1
  # PUT /configuraciones/1.json
  def update
    @configuracion = Configuracion.find(params[:id])
    nombre_antiguo = @configuracion.nombre
    direccion_antigua = @configuracion.direccion 
    telefono_antiguo = @configuracion.telefono 
    ciudad_antigua = @configuracion.ciudad 
    departamento_antiguo = @configuracion.departamento 
    email_antiguo = @configuracion.email 
    logo_antiguo = @configuracion.logo

    respond_to do |format|
      if @configuracion.update_attributes(params[:configuracion])
        nombre_nuevo = @configuracion.nombre
        direccion_nueva = @configuracion.direccion 
        telefono_nuevo = @configuracion.telefono 
        ciudad_nuevo = @configuracion.ciudad 
        departamento_nuevo = @configuracion.departamento 
        email_nuevo = @configuracion.email 
        logo_nuevo = @configuracion.logo
        CustomLogger.info("Los datos de configuracion antes de actualizar son: Nombre: #{nombre_antiguo.inspect}, direccion: #{direccion_antigua.inspect}, telefono: #{telefono_antiguo.inspect}, ciudad:#{ciudad_antigua.inspect}, departamento: #{departamento_antiguo.inspect}, email: #{email_antiguo.inspect}, logo: #{logo_antiguo.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son: nombre: #{nombre_nuevo.inspect}, direccion: #{direccion_nueva.inspect}, telefono: #{telefono_nuevo.inspect}, ciudad:#{ciudad_nuevo.inspect}, departamento: #{departamento_nuevo.inspect}, email: #{email_nuevo.inspect}, logo: #{logo_nuevo.inspect}, #{Time.now}")
        format.html { redirect_to @configuracion, notice: 'La configuracion ha sido actualizada correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @configuracion.errors, status: :unprocessable_entity }
      end
    end
  end

end
