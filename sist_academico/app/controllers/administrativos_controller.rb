require 'custom_logger'
class AdministrativosController < ApplicationController
  before_filter :require_login
  before_filter :admin_user
  # GET /administrativos
  # GET /administrativos.json
  def index
    @administrativos = Administrativo.order('created_at DESC').all
    @total = false
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @administrativos }
      format.pdf { render :layout => false }
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
    @new = true
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
    @new = false
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
        format.html { redirect_to @administrativo, notice: 'El administrativo ha sido creado con exito.' }
        CustomLogger.info("Nuevo administrativo: #{@administrativo.user_nombre.inspect} ,Apellido: #{@administrativo.user_apellido.inspect} ,Cedula de Identidad: #{@administrativo.user_CINro.inspect} ,Sexo: #{@administrativo.user_sexo.inspect} ,Telefono:#{@administrativo.user_telefono.inspect} ,Correo Electronico: #{@administrativo.user_email.inspect} ,Fecha de Nacimiento:#{@administrativo.user_fecha_nacimiento.inspect} ,Lugar de Nacimiento: #{@administrativo.user_lugar_nacimiento.inspect} ,Cargo: #{@administrativo.cargo.inspect} ,Titulo: #{@administrativo.titulo.inspect} ,Direccion: #{@administrativo.user.address.direccion.inspect} ,Nombre de Usuario: #{@administrativo.user_username.inspect} creado por el usuario: #{current_user.full_name.inspect} ,#{Time.now}")
        format.json { render json: @administrativo, status: :created, location: @administrativo }
        format.js   {}
      else
        @new = true
        atributos
        format.html { render action: "new" }
        CustomLogger.error("Error al querer crear el nuevo administrativo: #{@administrativo.user_nombre.inspect} y sus demas atributos, por el usuario: #{current_user.full_name.inspect} ,#{Time.now}")
        format.json { render json: @administrativo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /administrativos/1
  # PUT /administrativos/1.json
  def update
    @administrativo = Administrativo.find(params[:id])
    nombre_antiguo = @administrativo.user_nombre
    apellido_antiguo = @administrativo.user_apellido
    cedula_antiguo = @administrativo.user_CINro
    sexo_antiguo = @administrativo.user_sexo
    telefono_antiguo = @administrativo.user_telefono
    correo_antiguo = @administrativo.user_email
    fechaNac_antiguo = @administrativo.user_fecha_nacimiento
    lugarNac_antiguo = @administrativo.user_lugar_nacimiento
    direccion_antiguo = @administrativo.user.address.direccion
    cargo_antiguo = @administrativo.cargo
    titulo_antiguo = @administrativo.titulo
    nombreUsuario_antiguo = @administrativo.user_username

    respond_to do |format|
      if @administrativo.update_attributes(params[:administrativo])
        nombre_nuevo = @administrativo.user_nombre
        apellido_nuevo = @administrativo.user_apellido
        cedula_nuevo = @administrativo.user_CINro
        sexo_nuevo = @administrativo.user_sexo
        telefono_nuevo = @administrativo.user_telefono
        correo_nuevo = @administrativo.user_email
        fechaNac_nuevo = @administrativo.user_fecha_nacimiento
        lugarNac_nuevo = @administrativo.user_lugar_nacimiento
        direccion_nuevo = @administrativo.user.address.direccion
        cargo_nuevo = @administrativo.cargo
        titulo_nuevo = @administrativo.titulo
        nombreUsuario_nuevo = @administrativo.user_username
        user = @administrativo.user
        if user.is_docente
          unless user.docente
            d = Docente.new
            d.user_id = user.id
            d.titulo = params[:titulo]
            d.matricula = params[:matricula]
            unless d.save
              user.update_attribute(:is_docente, false);
            end
          end
        end
        if user.is_alumno
          unless user.alumno
            a = Alumno.new
            a.user_id = user.id
            a.responsable = params[:responsable]
            a.telefono_responsable = params[:telefono_responsable]
            a.curso_id = params[:curso_id].first.to_i
            a.doc_cedula = params[:doc_cedula]
            a.doc_cert_estudios = params[:doc_cert_estudios]
            a.doc_foto = params[:doc_foto]
            a.doc_cert_nacimiento = params[:doc_cert_nacimiento]
            unless a.save
              user.update_attribute(:is_alumno, false);
            else
              a.cursos << a.curso
            end
          end
        end

        CustomLogger.info("Los datos antes de ser actualizados son: Nombre de administrativo: #{nombre_antiguo.inspect} ,Apellido: #{apellido_antiguo.inspect} ,Cedula de Identidad: #{cedula_antiguo.inspect} ,Sexo: #{sexo_antiguo.inspect} ,Telefono:#{telefono_antiguo.inspect} ,Correo Electronico: #{correo_antiguo.inspect} ,Fecha de Nacimiento:#{fechaNac_antiguo.inspect} ,Lugar de Nacimiento: #{lugarNac_antiguo.inspect} ,Cargo: #{cargo_antiguo.inspect} ,Titulo: #{titulo_antiguo.inspect} ,Direccion: #{direccion_antiguo.inspect} ,Nombre de Usuario: #{nombreUsuario_antiguo.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son los siguientes: Nombre de administrativo: #{nombre_nuevo.inspect} ,Apellido: #{apellido_nuevo.inspect} ,Cedula de Identidad: #{cedula_nuevo.inspect} ,Sexo: #{sexo_nuevo.inspect} ,Telefono:#{telefono_nuevo.inspect} ,Correo Electronico: #{correo_nuevo.inspect} ,Fecha de Nacimiento:#{fechaNac_nuevo.inspect} ,Lugar de Nacimiento: #{lugarNac_nuevo.inspect} ,Cargo: #{cargo_nuevo.inspect} ,Titulo: #{titulo_nuevo.inspect} ,Direccion: #{direccion_nuevo.inspect} ,Nombre de Usuario: #{nombreUsuario_nuevo.inspect}, #{Time.now} ")
        format.html { redirect_to @administrativo, notice: "El administrativo ha sido actualizado con exito." }
        format.json { head :no_content }
      else
        @new = false
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
    @destruyo = false
    respond_to do |format|
      begin
        if @administrativo.destroy
            @destruyo = true
        end
        notice = "El administrativo y sus demas atributos han sido eliminado correctamente"
        CustomLogger.info("Administrativo: #{@administrativo.user_nombre.inspect} ,Apellido: #{@administrativo.user_apellido.inspect} ,Cedula de Identidad: #{@administrativo.user_CINro.inspect} ,Sexo: #{@administrativo.user_sexo.inspect} ,Telefono:#{@administrativo.user_telefono.inspect} ,Correo Electronico: #{@administrativo.user_email.inspect} ,Fecha de Nacimiento:#{@administrativo.user_fecha_nacimiento.inspect} ,Lugar de Nacimiento: #{@administrativo.user_lugar_nacimiento.inspect} ,Cargo: #{@administrativo.cargo.inspect} ,Titulo: #{@administrativo.titulo.inspect} ,Direccion: #{@administrativo.user.address.direccion.inspect} ,Nombre de Usuario: #{@administrativo.user_username.inspect} han sido eliminados por el usuario: #{current_user.full_name.inspect} ,#{Time.now}")
      rescue
        notice = "Este administrativo y sus demas campos no pueden ser eliminados"
        CustomLogger.error("Error al eliminar el administrativo: #{@administrativo.user_nombre.inspect} y sus demas atributos, por el usuario: #{current_user.full_name.inspect} ,#{Time.now}")
      ensure
        format.html { redirect_to administrativos_url, notice: notice }
        format.json { head :no_content }
        format.js
      end
    end
  end

  private
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
