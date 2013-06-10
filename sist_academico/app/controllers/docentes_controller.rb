class DocentesController < ApplicationController
  before_filter :require_login
  before_filter :admin_user, only: [:destroy, :index, :new, :create]
  before_filter :correct_user,   only: [:edit, :update, :show]
  # GET /docentes
  # GET /docentes.json
  def index
    @docentes = Docente.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @docentes }
    end
  end

  # GET /docentes/1
  # GET /docentes/1.json
  def show
    @docente = Docente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @docente }
    end
  end

  # GET /docentes/new
  # GET /docentes/new.json
  def new
    @docente = Docente.new
    @docente.build_user
    atributos
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @docente }
    end
  end

  # GET /docentes/1/edit
  def edit
    @docente = Docente.find(params[:id])
    atributos
  end

  # POST /docentes
  # POST /docentes.json
  def create
    @docente = Docente.new(params[:docente])
    user = @docente.user
    respond_to do |format|
      if @docente.save
        user = @docente.user
        edad = calcular_edad user
        user.update_attribute(:is_docente, true)
        user.update_attribute(:edad, edad )
        format.html { redirect_to @docente, notice: 'El Docente ha sido guardado.' }
        format.json { render json: @docente, status: :created, location: @docente }
        format.js   {}
      else
        atributos
        format.html { render action: "new" }
        format.json { render json: @docente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /docentes/1
  # PUT /docentes/1.json
  def update
    @docente = Docente.find(params[:id])
    user = @docente.user
    edad = calcular_edad user
    user.update_attribute(:edad, edad )
    respond_to do |format|
      if @docente.update_attributes(params[:docente])
        format.html { redirect_to @docente, notice: 'El docente ha sido actualizado.' }
        format.json { head :no_content }
      else
        atributos
        format.html { render action: "edit" }
        format.json { render json: @docente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docentes/1
  # DELETE /docentes/1.json
  def destroy
    @docente = Docente.find(params[:id])
    @docente.destroy

    respond_to do |format|
      format.html { redirect_to docentes_url }
      format.json { head :no_content }
    end
  end

  private
    def correct_user
      @user = Docente.find(params[:id]).user
      redirect_to(root_path) unless (current_user == @user || current_user.is_administrativo?)
    end

    def atributos
      @addresses = Address.order("created_at desc").find(:all)
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
