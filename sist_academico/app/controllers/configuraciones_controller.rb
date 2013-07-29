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
        format.html { redirect_to @configuracion, notice: 'Configuracion was successfully created.' }
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

    respond_to do |format|
      if @configuracion.update_attributes(params[:configuracion])
        format.html { redirect_to @configuracion, notice: 'Configuracion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @configuracion.errors, status: :unprocessable_entity }
      end
    end
  end

end
