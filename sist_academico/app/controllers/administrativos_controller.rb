class AdministrativosController < ApplicationController
  before_filter :require_login
  before_filter :admin_user
  # GET /administrativos
  # GET /administrativos.json
  def index
    @administrativos = Administrativo.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @administrativos }
    end
  end

  # GET /administrativos/1
  # GET /administrativos/1.json
  def show
    @administrativo = Administrativo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @administrativo }
    end
  end

  # GET /administrativos/new
  # GET /administrativos/new.json
  def new
    @administrativo = Administrativo.new
    @administrativo.build_user
    atributos
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @administrativo }
    end
  end

  # GET /administrativos/1/edit
  def edit
    @administrativo = Administrativo.find(params[:id])
    atributos
  end

  # POST /administrativos
  # POST /administrativos.json
  def create
    @administrativo = Administrativo.new(params[:administrativo])
    respond_to do |format|
      if @administrativo.save
          user = @administrativo.user
          edad = calcular_edad user
          user.update_attribute(:is_administrativo, true)
          user.update_attribute(:edad, edad )
        format.html { redirect_to @administrativo, notice: 'El administrativo ha sido creado.' }
        format.json { render json: @administrativo, status: :created, location: @administrativo }
      else
        atributos
        format.html { render action: "new" }
        format.json { render json: @administrativo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /administrativos/1
  # PUT /administrativos/1.json
  def update
    @administrativo = Administrativo.find(params[:id])

    respond_to do |format|
      if @administrativo.update_attributes(params[:administrativo])
        format.html { redirect_to @administrativo, notice: 'El administrativo ha sido actualizado.' }
        format.json { head :no_content }
      else
        atributos
        format.html { render action: "edit" }
        format.json { render json: @administrativo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrativos/1
  # DELETE /administrativos/1.json
  def destroy
    @administrativo = Administrativo.find(params[:id])
    @administrativo.destroy

    respond_to do |format|
      format.html { redirect_to administrativos_url }
      format.json { head :no_content }
    end
  end

  private
    def atributos
      @addresses = Address.find(:all)
      cities_city = []
      ciudades = City.find(:all)
      ciudades.each do |city|
        cities_city << city.city
      end
      @cities_city= cities_city
      @cursos = Curso.find(:all)
      @users = User.find(:all)
      addresses_new
    end

    def addresses_new
      @direccion = Address.new
      @cities = City.find(:all)
    end
end
