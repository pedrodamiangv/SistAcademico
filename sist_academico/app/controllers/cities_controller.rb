require 'custom_logger'

class CitiesController < ApplicationController
  before_filter :require_login
  before_filter :admin_user, only: [:destroy, :edit, :update, :new, :create]
  # GET /cities
  # GET /cities.json
  def index
    @cities = City.order('created_at DESC').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cities }
    end
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
    @city = City.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @city }
    end
  end

  # GET /cities/new
  # GET /cities/new.json
  def new
    @city = City.new
    @countries = Country.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @city }
    end
  end

  # GET /cities/1/edit
  def edit
    @city = City.find(params[:id])
    @countries = Country.find(:all)
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new (params[:city])

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'Ciudad creada con exito.' }
        CustomLogger.info("Nueva ciudad: #{@city.city.inspect} del pais #{@city.country_pais.inspect} creada por #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @city, status: :created, location: @city }
      else
        @countries = Country.find(:all)
        format.html { render action: "new" }
        CustomLogger.error("Error al crear una ciudad: #{@city.city.inspect} del pais #{@city.country_pais.inspect} .Usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cities/1
  # PUT /cities/1.json
  def update
    @city = City.find(params[:id])
    ciudad_antigua = @city.city
    pais_antiguo =  @city.country_pais
    respond_to do |format|
      if @city.update_attributes(params[:city])
        ciudad_nueva = @city.city
        pais_nuevo =  @city.country_pais
        CustomLogger.info("Los datos antes de actualizar son: Ciudad #{ciudad_antigua.inspect} del pais #{pais_antiguo.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son: Ciudad #{ciudad_nueva.inspect} del pais #{pais_nuevo.inspect}, #{Time.now}")
        format.html { redirect_to @city, notice: 'La ciudad fue actualizada con exito' }
        format.json { head :no_content }
      else
        @countries = Country.find(:all)
        format.html { render action: "edit" }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city = City.find(params[:id])
    respond_to do |format|
      begin
        @city.destroy
        notice= "La ciudad ha sido eliminada"
        CustomLogger.info("Ciudad #{@city.city.inspect} del pais #{@city.country_pais.inspect} eliminada por #{current_user.full_name.inspect}, #{Time.now}")
      rescue
        notice= "Esta ciudad no puede ser eliminada"
        CustomLogger.error("Error al eliminar la ciudad: #{@city.city.inspect} del pais #{@city.country_pais.inspect} .Usuario: #{current_user.full_name.inspect}, #{Time.now}")
      ensure
        format.html { redirect_to cities_url, notice: notice }
        format.json { head :no_content }
      end
    end
  end
end
