require 'custom_logger'

class CountriesController < ApplicationController
  before_filter :require_login
  before_filter :admin_user, only: [:destroy, :edit, :update, :new, :create]
  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
    @country = Country.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @country }
    end
  end

  # GET /countries/new
  # GET /countries/new.json
  def new
    @country = Country.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @country }
    end
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.new(params[:country])

    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'EL Pais ha sido creado con exito. ' }
        CustomLogger.info("Nuevo pais: #{@country.pais.inspect} creado por el usuario: #{current_user.full_name.inspect}, #{Time.now}" )
        format.json { render json: @country, status: :created, location: @country }
      else
        format.html { render action: "new" }
        CustomLogger.error("Error al crear el pais #{@country.pais.inspect} por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /countries/1
  # PUT /countries/1.json
  def update
    @country = Country.find(params[:id])
    pais_antiguo = @country.pais
    respond_to do |format|
      if @country.update_attributes(params[:country])
        pais_nuevo = @country.pais
        CustomLogger.info("Los datos antes de actualizar son #{pais_antiguo.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son: #{pais_nuevo.inspect}, #{Time.now}")
        format.html { redirect_to @country, notice: 'El pais ha sido actualizado. ' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country = Country.find(params[:id])
    respond_to do |format|
      begin
        @country.destroy
        notice = "El pais ha sido eliminado"
        CustomLogger.info("Pais: #{@country.pais.inspect} ha sido eliminado por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      rescue
        notice = "Este pais no puede ser eliminado"
        CustomLogger.error("Error al querer eliminar el pais #{@country.pais.inspect} por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      ensure
      format.html { redirect_to countries_url, notice: notice }
      format.json { head :no_content }
      end
    end
  end
end
