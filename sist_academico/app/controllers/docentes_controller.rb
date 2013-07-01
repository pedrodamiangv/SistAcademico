require 'custom_logger'
class DocentesController < ApplicationController
  before_filter :require_login
  before_filter :admin_user, only: [:destroy, :index, :new, :create]
  before_filter :correct_user,   only: [:edit, :update, :show]
  # GET /docentes
  # GET /docentes.json
  def index_total
    @docentes = Docente.order('created_at DESC').all
    @total = true
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @docentes }
      format.pdf { render 'index', :layout => false }
    end
  end

  def index
    @docentes = []
    materias = Materia.by_year(Date.today.year)
    @total = false
    materias.each do |materia|
      @docentes << materia.docente
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @docentes }
      format.pdf { render :layout => false }
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
    @new = true
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
    @new = false
    @docente = Docente.find(params[:id])
    atributos
    @endereco = @docente.user.address
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
        format.html { redirect_to @docente, notice: 'El Docente ha sido registrado con exito. ' }
        CustomLogger.info("Nuevo docente: #{@docente.user_nombre.inspect} ,Apellido: #{@docente.user_apellido.inspect} ,Cedula de Identidad: #{@docente.user_CINro.inspect} ,Sexo: #{@docente.user_sexo.inspect} ,Telefono:#{@docente.user_telefono.inspect} ,Correo Electronico: #{@docente.user_email.inspect} ,Fecha de Nacimiento:#{@docente.user_fecha_nacimiento.inspect} ,Lugar de Nacimiento: #{@docente.user_lugar_nacimiento.inspect} ,Matricula Numero: #{@docente.matricula.inspect} ,Titulo: #{@docente.titulo.inspect} ,Direccion: #{@docente.user.address.direccion.inspect} ,Nombre de Usuario: #{@docente.user_username.inspect} creado por el usuario: #{current_user.full_name.inspect} ,#{Time.now}")
        format.json { render json: @docente, status: :created, location: @docente }
        format.js   {}
      else
        @new = true
        atributos
        format.html { render action: "new" }
        CustomLogger.error("Error al querer crear un nuevo docente: #{@docente.user_nombre.inspect} y sus demas atributos, por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @docente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /docentes/1
  # PUT /docentes/1.json
  def update
    @docente = Docente.find(params[:id])
    nombre_antiguo = @docente.user_nombre
    apellido_antiguo = @docente.user_apellido
    cedula_antiguo = @docente.user_CINro
    sexo_antiguo = @docente.user_sexo
    telefono_antiguo = @docente.user_telefono
    correo_antiguo = @docente.user_email
    fechaNac_antiguo = @docente.user_fecha_nacimiento
    lugarNac_antiguo = @docente.user_lugar_nacimiento
    direccion_antiguo = @docente.user.address.direccion
    matricula_antiguo = @docente.matricula
    titulo_antiguo = @docente.titulo
    nombreUsuario_antiguo = @docente.user_username

    user = @docente.user
    edad = calcular_edad user
    user.update_attribute(:edad, edad )
    respond_to do |format|
      if @docente.update_attributes(params[:docente])
        nombre_nuevo = @docente.user_nombre
        apellido_nuevo = @docente.user_apellido
        cedula_nuevo = @docente.user_CINro
        sexo_nuevo = @docente.user_sexo
        telefono_nuevo = @docente.user_telefono
        correo_nuevo = @docente.user_email
        fechaNac_nuevo = @docente.user_fecha_nacimiento
        lugarNac_nuevo = @docente.user_lugar_nacimiento
        direccion_nuevo = @docente.user.address.direccion
        matricula_nuevo = @docente.matricula
        titulo_nuevo = @docente.titulo
        nombreUsuario_nuevo = @docente.user_username
        CustomLogger.info("Los datos antes de ser actualizados son: Nombre del docente: #{nombre_antiguo.inspect} ,Apellido: #{apellido_antiguo.inspect} ,Cedula de Identidad: #{cedula_antiguo.inspect} ,Sexo: #{sexo_antiguo.inspect} ,Telefono:#{telefono_antiguo.inspect} ,Correo Electronico: #{correo_antiguo.inspect} ,Fecha de Nacimiento:#{fechaNac_antiguo.inspect} ,Lugar de Nacimiento: #{lugarNac_antiguo.inspect} ,Matricula Numero: #{matricula_antiguo.inspect} ,Titulo: #{titulo_antiguo.inspect} ,Direccion: #{direccion_antiguo.inspect} ,Nombre de Usuario: #{nombreUsuario_antiguo.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son los siguientes: Nombre del docente: #{nombre_nuevo.inspect} ,Apellido: #{apellido_nuevo.inspect} ,Cedula de Identidad: #{cedula_nuevo.inspect} ,Sexo: #{sexo_nuevo.inspect} ,Telefono:#{telefono_nuevo.inspect} ,Correo Electronico: #{correo_nuevo.inspect} ,Fecha de Nacimiento:#{fechaNac_nuevo.inspect} ,Lugar de Nacimiento: #{lugarNac_nuevo.inspect} ,Matricula Numero: #{matricula_nuevo.inspect} ,Titulo: #{titulo_nuevo.inspect} ,Direccion: #{direccion_nuevo.inspect} ,Nombre de Usuario: #{nombreUsuario_nuevo.inspect}, #{Time.now} ")
        format.html { redirect_to @docente, notice: 'El docente ha sido actualizado con exito.' }
        format.json { head :no_content }
      else
        @new = false
        atributos
        @endereco = @docente.user.address
        format.html { render action: "edit" }
        format.json { render json: @docente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docentes/1
  # DELETE /docentes/1.json
  def destroy
    @docente = Docente.find(params[:id])
    @destruyo = false
    respond_to do |format|
      begin
        if @docente.destroy
          @destruyo = true
        end
        notice = "El docente y sus demas atributos han sido eliminados correctamente. "
        CustomLogger.info("Nombre del docente: #{@docente.user_nombre.inspect} ,Apellido: #{@docente.user_apellido.inspect} ,Cedula de Identidad: #{@docente.user_CINro.inspect} ,Sexo: #{@docente.user_sexo.inspect} ,Telefono:#{@docente.user_telefono.inspect} ,Correo Electronico: #{@docente.user_email.inspect} ,Fecha de Nacimiento:#{@docente.user_fecha_nacimiento.inspect} ,Lugar de Nacimiento: #{@docente.user_lugar_nacimiento.inspect} ,Matricula Numero: #{@docente.matricula.inspect} ,Titulo: #{@docente.titulo.inspect} ,Direccion: #{@docente.user.address.direccion.inspect} ,Nombre de Usuario: #{@docente.user_username.inspect} han sido eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      rescue
        notice = "Este docente y sus demas atributos no pueden ser eliminados. "
        CustomLogger.error("El docente #{@docente.user_nombre.inspect} y sus demas atributos no pueden ser eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      ensure
        format.html { redirect_to docentes_url, notice: notice }
        format.json { head :no_content }
        format.js
      end
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
