class AlumnosController < ApplicationController
  before_filter :require_login
  before_filter :correct_user || :admin_user,   only: [:edit, :update, :show] 
  before_filter :admin_user,   only: [:new, :create, :destroy]
  # GET /alumnos
  # GET /alumnos.json
  def index
    @alumnos = Alumno.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
    end
  end

  # GET /alumnos/1
  # GET /alumnos/1.json
  def show
    @alumno = Alumno.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alumno }
    end
  end

  # GET /alumnos/new
  # GET /alumnos/new.json
  def new
    @alumno = Alumno.new
    @alumno.build_user
    atributos
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alumno }
    end
  end

  # GET /alumnos/1/edit
  def edit
    @alumno = Alumno.find(params[:id])
    atributos
  end

  # POST /alumnos
  # POST /alumnos.json
  def create
    @alumno = Alumno.new(params[:alumno])
    respond_to do |format|
        if @alumno.save
          user = @alumno.user
          edad = calcular_edad user
          user.update_attribute(:is_alumno, true)
          user.update_attribute(:edad, edad )
          format.html { redirect_to @alumno, notice: 'El alumno ha sido registrado.' }
          format.json { render json: @alumno, status: :created, location: @alumno }
        else
          atributos
          format.html { render action: "new" }
          format.json { render json: @alumno.errors, status: :unprocessable_entity }
        end
    end
  end

  # PUT /alumnos/1
  # PUT /alumnos/1.json
  def update
    @alumno = Alumno.find(params[:id])

    respond_to do |format|
      if @alumno.update_attributes(params[:alumno])
        format.html { redirect_to @alumno, notice: 'El alumno ha sido actualizado.' }
        format.json { head :no_content }
      else
        atributos
        format.html { render action: "edit" }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnos/1
  # DELETE /alumnos/1.json
  def destroy
    @alumno = Alumno.find(params[:id])
    @alumno.destroy

    respond_to do |format|
      format.html { redirect_to alumnos_url }
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

    def correct_user
      @user = Alumno.find(params[:id]).user
      redirect_to(root_path) unless (current_user == @user || current_user.is_administrativo?)
    end
end
