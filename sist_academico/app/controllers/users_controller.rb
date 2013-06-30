require 'custom_logger'
class UsersController < ApplicationController
  before_filter :require_login
  before_filter :correct_user,   only: [:edit, :update, :show]
  before_filter :admin_user,   only: [:new, :create, :destroy]

  def index
    @users = User.order('created_at DESC').all
  end

  def new
  	@user = User.new
    @cities_city = cities
    @addresses = Address.order("created_at desc").find(:all)
    addresses_new
	end

	def create
	  @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        @user.edad = calcular_edad @user
        user.update_attribute(:edad, edad )
        format.html { redirect_to @user, notice: 'El Usuario ha sido registrado con exito.' }
        CustomLogger.info("Nuevo Usuario: #{@user_nombre.inspect} ,Apellido: #{@user_apellido.inspect} ,Cedula de Identidad: #{@user_CINro.inspect} ,Sexo: #{@user_sexo.inspect} ,Telefono:#{@user_telefono.inspect} ,Correo Electronico: #{@user_email.inspect} ,Fecha de Nacimiento:#{@user_fecha_nacimiento.inspect} ,Lugar de Nacimiento: #{@user_lugar_nacimiento.inspect} ,Direccion: #{@user.address.direccion.inspect} ,Nombre de Usuario: #{@user_username.inspect} creado por el usuario: #{current_user.full_name.inspect} ,#{Time.now}")
        format.json { render json: @user, status: :created, location: @user }
        format.js   {}
      else
        @addresses = Address.order("created_at desc").find(:all)
        @cities_city = cities
        addresses_new
        format.html { render action: "new" }
        CustomLogger.error("Error al querer crear el usuario: #{@user_nombre.inspect} y sus demas atributos, por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	end

	def edit
    @user = User.find(params[:id])
    @cities_city = cities
    @addresses = Address.find(:all)
    addresses_new
  end

  def update
    @user = User.new (params[:user])
    nombre_antiguo = @user_nombre
    apellido_antiguo = @user_apellido
    cedula_antiguo = @user_CINro
    sexo_antiguo = @user_sexo
    telefono_antiguo = @user_telefono
    correo_antiguo = @user_email
    fechaNac_antiguo = @user_fecha_nacimiento
    lugarNac_antiguo = @user_lugar_nacimiento
    direccion_antiguo = @user.address.direccion
    nombreUsuario_antiguo = @user_username

    respond_to do |format|
      if @user.update_attributes(params[:user])
        nombre_nuevo = @user_nombre
        apellido_nuevo = @user_apellido
        cedula_nuevo = @user_CINro
        sexo_nuevo = @user_sexo
        telefono_nuevo = @user_telefono
        correo_nuevo = @user_email
        fechaNac_nuevo = @user_fecha_nacimiento
        lugarNac_nuevo = @user_lugar_nacimiento
        direccion_nuevo = @user.address.direccion
        nombreUsuario_nuevo = @user_username

        CustomLogger.info("Los datos antes de ser actualizados son: Nombre: #{nombre_antiguo.inspect} ,Apellido: #{apellido_antiguo.inspect} ,Cedula de Identidad: #{cedula_antiguo.inspect} ,Sexo: #{sexo_antiguo.inspect} ,Telefono:#{telefono_antiguo.inspect} ,Correo Electronico: #{correo_antiguo.inspect} ,Fecha de Nacimiento:#{fechaNac_antiguo.inspect} ,Lugar de Nacimiento: #{lugarNac_antiguo.inspect} ,Direccion: #{direccion_antiguo.inspect} ,Nombre de Usuario: #{nombreUsuario_antiguo.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son los siguientes: #{nombre_nuevo.inspect} ,Apellido: #{apellido_nuevo.inspect} ,Cedula de Identidad: #{cedula_nuevo.inspect} ,Sexo: #{sexo_nuevo.inspect} ,Telefono:#{telefono_nuevo.inspect} ,Correo Electronico: #{correo_nuevo.inspect} ,Fecha de Nacimiento:#{fechaNac_nuevo.inspect} ,Lugar de Nacimiento: #{lugarNac_nuevo.inspect} ,Direccion: #{direccion_nuevo.inspect} ,Nombre de Usuario: #{nombreUsuario_nuevo.inspect}, #{Time.now}")
        format.html { redirect_to @user, notice: 'Los campos han sido actualizados correctamente.' }   
      else
        @addresses = Address.order("created_at desc").find(:all)
        @cities_city = cities
        addresses_new
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    respond_to do |format|
      begin
        @user.destroy
        notice = "El usuario y sus demas atributos han sido eliminado correctamente. "
        CustomLogger.info("Usuario: #{@user_nombre.inspect} ,Apellido: #{@user_apellido.inspect} ,Cedula de Identidad: #{@user_CINro.inspect} ,Sexo: #{@user_sexo.inspect} ,Telefono:#{@user_telefono.inspect} ,Correo Electronico: #{@user_email.inspect} ,Fecha de Nacimiento:#{@user_fecha_nacimiento.inspect} ,Lugar de Nacimiento: #{@user_lugar_nacimiento.inspect} ,Direccion: #{@user.address.direccion.inspect} ,Nombre de Usuario: #{@user_username.inspect} han sido eliminados por el usuario: #{current_user.full_name.inspect} ,#{Time.now}")
      rescue
        notice = "Este usuario y sus demas atributos no pueden ser eliminados"
        CustomLogger.error("Error al eliminar el usuario: #{@user_nombre.inspect} y sus demas atributos, por el usuario: #{current_user.full_name.inspect}, #{Time.now} ")
      ensure
        format.html { redirect_to users_url, notice: notice }
        format.json { head :no_content }
      end
    end
  end

  def addresses_new
      @direccion = Address.new
      @cities = City.find(:all)
  end

  private
    def cities
      cities_city = []
      cities = City.find(:all)
      cities.each do |city|
        cities_city << city.city
      end
      return cities_city
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless (current_user == @user || current_user.is_administrativo?)
    end

end
