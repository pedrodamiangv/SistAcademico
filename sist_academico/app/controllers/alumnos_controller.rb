require 'custom_logger'
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

  def alumno_calificaciones
    @alumno = Alumno.find(params[:id])
    @materias = @alumno.curso.materias
    @calificaciones_primera_etapa = []
    @calificaciones_segunda_etapa = []
    @calificaciones_tercera_etapa = []
    @materias.each do |materia|
      calificacion_etapa_uno = materia.calificaciones.where(:etapa => 'Primera', :alumno_id => @alumno.id)
      unless calificacion_etapa_uno.count == 0
        @calificaciones_primera_etapa << calificacion_etapa_uno.first 
      end 
      
      calificacion_etapa_dos = materia.calificaciones.where(:etapa => 'Segunda', :alumno_id => @alumno.id)
      unless calificacion_etapa_dos.count == 0
        @calificaciones_segunda_etapa << calificacion_etapa_dos.first 
      end 
      
      calificacion_etapa_tres = materia.calificaciones.where(:etapa => 'Tercera', :alumno_id => @alumno.id)
      unless calificacion_etapa_tres.count == 0
        @calificaciones_tercera_etapa << calificacion_etapa_tres.first 
      end 
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
          format.html { redirect_to @alumno, notice: 'El alumno ha sido registrado con exito.' }
          CustomLogger.info("Nuevo alumno: #{@alumno.user_nombre.inspect} ,Apellido: #{@alumno.user_apellido.inspect} ,Cedula de Identidad: #{@alumno.user_CINro.inspect} ,Sexo: #{@alumno.user_sexo.inspect} ,Telefono:#{@alumno.user_telefono.inspect} ,Correo Electronico: #{@alumno.user_email.inspect} ,Fecha de Nacimiento:#{@alumno.user_fecha_nacimiento.inspect} ,Lugar de Nacimiento: #{@alumno.user_lugar_nacimiento.inspect} ,Nombre del Responsable: #{@alumno.responsable.inspect} ,Telefono del Responsable: #{@alumno.telefono_responsable.inspect} ,Direccion: #{@alumno.user.address.direccion.inspect} ,Documentos Personales: Certificado de Estudio: #{@alumno.doc_cert_estudios.inspect} ,Cedula: #{@alumno.doc_cedula.inspect} ,Certificado de Nacimiento: #{@alumno.doc_cert_nacimiento.inspect} ,Foto Tipo Carnet: #{@alumno.doc_foto.inspect} ,Nombre de Usuario: #{@alumno.user_username.inspect} creado por el usuario: #{current_user.full_name.inspect} ,#{Time.now}")
          format.json { render json: @alumno, status: :created, location: @alumno }
          format.js   {}
        else
          atributos
          format.html { render action: "new" }
          CustomLogger.error("Error al querer crear el nuevo alumno: #{@alumno.user_nombre.inspect} y sus demas atributos, por el usuario: #{current_user.full_name.inspect} ,#{Time.now}")
          format.json { render json: @alumno.errors, status: :unprocessable_entity }
        end
    end
  end

  # PUT /alumnos/1
  # PUT /alumnos/1.json
  def update
    @alumno = Alumno.find(params[:id])
    nombre_antiguo = @alumno.user_nombre
    apellido_antiguo = @alumno.user_apellido
    cedula_antiguo = @alumno.user_CINro
    sexo_antiguo = @alumno.user_sexo
    telefono_antiguo = @alumno.user_telefono
    correo_antiguo = @alumno.user_email
    fechaNac_antiguo = @alumno.user_fecha_nacimiento
    lugarNac_antiguo = @alumno.user_lugar_nacimiento
    direccion_antiguo = @alumno.user.address.direccion
    responsable_antiguo = @alumno.responsable
    telefonoRespon_antiguo = @alumno.telefono_responsable
    doc_cedula_antiguo = @alumno.doc_cedula
    doc_cert_estudios_antiguo = @alumno.doc_cert_estudios
    doc_cert_nacimiento_antiguo = @alumno.doc_cert_nacimiento
    doc_foto_antiguo = @alumno.doc_foto
    nombreUsuario_antiguo = @alumno.user_username

    respond_to do |format|
      if @alumno.update_attributes(params[:alumno])
        nombre_nuevo = @alumno.user_nombre
        apellido_nuevo = @alumno.user_apellido
        cedula_nuevo = @alumno.user_CINro
        sexo_nuevo = @alumno.user_sexo
        telefono_nuevo = @alumno.user_telefono
        correo_nuevo = @alumno.user_email
        fechaNac_nuevo = @alumno.user_fecha_nacimiento
        lugarNac_nuevo = @alumno.user_lugar_nacimiento
        direccion_nuevo = @alumno.user.address.direccion
        responsable_nuevo = @alumno.responsable
        telefonoRespon_nuevo = @alumno.telefono_responsable
        doc_cedula_nuevo = @alumno.doc_cedula
        doc_cert_estudios_nuevo = @alumno.doc_cert_estudios
        doc_cert_nacimiento_nuevo = @alumno.doc_cert_nacimiento
        doc_foto_nuevo = @alumno.doc_foto
        nombreUsuario_nuevo = @alumno.user_username
        CustomLogger.info("Los datos antes de ser actualizados son: Nombre del alumno: #{nombre_antiguo.inspect} ,Apellido: #{apellido_antiguo.inspect} ,Cedula de Identidad: #{cedula_antiguo.inspect} ,Sexo: #{sexo_antiguo.inspect} ,Telefono:#{telefono_antiguo.inspect} ,Correo Electronico: #{correo_antiguo.inspect} ,Fecha de Nacimiento:#{fechaNac_antiguo.inspect} ,Lugar de Nacimiento: #{lugarNac_antiguo.inspect} ,Nombre del Responsable: #{responsable_antiguo.inspect} ,Telefono del Responsable: #{telefonoRespon_antiguo.inspect} ,Direccion: #{direccion_antiguo.inspect} ,Documentos Personales: Foto Tipo Carnet: #{doc_foto_antiguo.inspect} ,Cedula: #{doc_cedula_antiguo.inspect} ,Certificado de Nacimiento: #{doc_cert_nacimiento_antiguo.inspect} ,Certificado de Estudio: #{doc_cert_estudios_antiguo.inspect} ,Nombre de Usuario: #{nombreUsuario_antiguo.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son los siguientes: Nombre del alumno: #{nombre_nuevo.inspect} ,Apellido: #{apellido_nuevo.inspect} ,Cedula de Identidad: #{cedula_nuevo.inspect} ,Sexo: #{sexo_nuevo.inspect} ,Telefono:#{telefono_nuevo.inspect} ,Correo Electronico: #{correo_nuevo.inspect} ,Fecha de Nacimiento:#{fechaNac_nuevo.inspect} ,Lugar de Nacimiento: #{lugarNac_nuevo.inspect} ,Nombre del Responsable: #{responsable_nuevo.inspect} ,Telefono del Responsable: #{telefonoRespon_nuevo.inspect} ,Direccion: #{direccion_nuevo.inspect} ,Documentos Personales: Foto Tipo Carnet: #{doc_foto_nuevo.inspect} ,Cedula: #{doc_cedula_nuevo.inspect} ,Certificado de Nacimiento: #{doc_cert_nacimiento_nuevo.inspect} ,Certificado de Estudio: #{doc_cert_estudios_nuevo.inspect} ,Nombre de Usuario: #{nombreUsuario_nuevo.inspect} ,#{Time.now} ")
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
    respond_to do |format|
      begin
        @alumno.destroy
        notice = "El alumnos y sus demas atributos han sido eliminados correctamente. "
        CustomLogger.info("Nombre del alumno: #{@alumno.user_nombre.inspect} ,Apellido: #{@alumno.user_apellido.inspect} ,Cedula de Identidad: #{@alumno.user_CINro.inspect} ,Sexo: #{@alumno.user_sexo.inspect} ,Telefono:#{@alumno.user_telefono.inspect} ,Correo Electronico: #{@alumno.user_email.inspect} ,Fecha de Nacimiento:#{@alumno.user_fecha_nacimiento.inspect} ,Lugar de Nacimiento: #{@alumno.user_lugar_nacimiento.inspect} ,Nombre del Responsable: #{@alumno.responsable.inspect} ,Telefono del Responsable: #{@alumno.telefono_responsable.inspect} ,Direccion: #{@alumno.user.address.direccion.inspect} ,Documentos Personales: Certificado de Estudio: #{@alumno.doc_cert_estudios.inspect} ,Cedula: #{@alumno.doc_cedula.inspect} ,Certificado de Nacimiento: #{@alumno.doc_cert_nacimiento.inspect} ,Foto Tipo Carnet: #{@alumno.doc_foto.inspect} ,Nombre de Usuario: #{@alumno.user_username.inspect} han sido eliminados por el usuario: #{current_user.full_name.inspect} ,#{Time.now}")
      rescue
        notice = "Este alumnos y sus demas atributos no pueden ser eliminados"
        CustomLogger.error("Error al eliminar el alumno: Nombre del alumno: #{@alumno.user_nombre.inspect} y sus demas atributos, por el usuario: #{current_user.full_name.inspect} ,#{Time.now} ")
      ensure
        format.html { redirect_to alumnos_url, notice: notice }
        format.json { head :no_content }
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

    def correct_user
      @user = Alumno.find(params[:id]).user
      redirect_to(root_path) unless (current_user == @user || current_user.is_administrativo?)
    end
end
