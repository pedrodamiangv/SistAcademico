class AddressesController < ApplicationController
  before_filter :require_login
  before_filter :admin_user, only: [:destroy, :edit, :update, :new, :create]
  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @addresses }
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
    respond_to do |format|
      if @address.save
        @addresses = Address.order("created_at desc").find(:all)
        format.html { redirect_to @address, notice: 'La direccion ha sido registrado.' }
        format.json { render json: @address, status: :created, location: @address }
        format.js   {}
      else
        @cities = City.find(:all)
        format.html { render action: "new" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /addresses/1
  # PUT /addresses/1.json
  def update
    @address = Address.find(params[:id])
    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html { redirect_to @address, notice: 'La direccion ha sido actualizada.' }
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
    @address.destroy

    respond_to do |format|
      format.html { redirect_to addresses_url }
      format.json { head :no_content }
    end
  end
  
end
