require 'custom_logger'
class AddressesController < ApplicationController
  before_filter :require_login
  before_filter :admin_user, only: [:destroy, :edit, :update, :new, :create]
  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.order('created_at DESC').all
    @total = false
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @addresses }
      format.pdf { render :layout => false }
    end
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
    @address = Address.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @address }
    end
  end

  # GET /addresses/new
  # GET /addresses/new.json
  def new
    @page = ''
    @address = Address.new
    @cities = City.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @address }
    end
  end

  # GET /addresses/1/edit
  def edit
    @address = Address.find(params[:id])
    @cities = City.find(:all)
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(params[:address])
    @new = true
    respond_to do |format|
      if @address.save
        @addresses = Address.order("created_at desc").find(:all)
        format.html { redirect_to @address, notice: 'La direccion ha sido creada con exito. ' }
        CustomLogger.info("Nueva direccion: #{@address.direccion.inspect} ,Barrio: #{@address.barrio.inspect} ,Ciudad: #{@address.city_city.inspect} creado por el usuario #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @address, status: :created, location: @address }
        format.js   { render 'create' }
      else
        @cities = City.find(:all)
        format.html { render action: "new" }
        CustomLogger.error("Error al crear direccion: #{@address.direccion.inspect} ,Barrio: #{@address.barrio.inspect} ,Ciudad: #{@address.city_city.inspect} por el usuario #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @address.errors, status: :unprocessable_entity }
        format.js   { render 'create_false' }
      end
    end
  end

  # PUT /addresses/1
  # PUT /addresses/1.json
  def update
    @address = Address.find(params[:id])
    direccion_antigua = @address.direccion
    barrio_antiguo = @address.barrio
    ciudad_antigua = @address.city_city
    respond_to do |format|
      if @address.update_attributes(params[:address])
        direccion_nueva = @address.direccion
        barrio_nuevo = @address.barrio
        ciudad_nueva = @address.city_city
        CustomLogger.info("Los datos antes de actualizar son: Direccion: #{direccion_antigua.inspect} ,Barrio:#{barrio_antiguo.inspect} ,Ciudad:#{ciudad_antigua.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son: Direccion: #{direccion_nueva.inspect} ,Barrio:#{barrio_nuevo.inspect} ,Ciudad:#{ciudad_nueva.inspect}, #{Time.now}")
        format.html { redirect_to @address, notice: 'La direccion ha sido actualizada correctamente.' }
        format.json { head :no_content }
      else
        @cities = City.find(:all)
        format.html { render action: "edit" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address = Address.find(params[:id])
    respond_to do |format|
      begin
        @address.destroy
        notice = "La direccion ha sido eliminada correctamente"
        CustomLogger.info("Direccion: #{@address.direccion.inspect} ,Barrio: #{@address.barrio.inspect} ,Ciudad: #{@address.city_city.inspect} eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      rescue
        notice = "Esta direccion y sus demas campos no pueden ser eliminados"
        CustomLogger.error("Error al eliminar la direccion: #{@address.direccion.inspect} y sus demas campos, por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      ensure
        format.html { redirect_to addresses_url, notice: notice }
        format.json { head :no_content }
      end
    end
  end
end
