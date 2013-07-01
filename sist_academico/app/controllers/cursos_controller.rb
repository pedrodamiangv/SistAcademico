require 'custom_logger'
class CursosController < ApplicationController
  before_filter :require_login
  before_filter :admin_user, only: [:destroy, :edit, :update, :new, :create]
 

  def index_total
    @cursos = Curso.order('created_at DESC').all
    @total = true
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cursos }
      format.pdf { render 'index', :layout => false }
    end

  end

  # GET /cursos
  # GET /cursos.json
  def index
    @cursos = Curso.by_year(Date.today.year).all
    @total = false
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cursos }
      format.pdf { render :layout => false }
    end
  end

  # GET /cursos/1
  # GET /cursos/1.json
  def show
    @curso = Curso.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @curso }
      format.pdf { render :layout => false }
    end
  end

  # GET /cursos/new
  # GET /cursos/new.json
  def new
    @curso = Curso.new
    @cursos = obtain_cursos "Grado"
    @secciones = obtain_seccion "Primer", "Grado"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @curso }
    end
  end

  # GET /cursos/1/edit
  def edit
    @curso = Curso.find(params[:id])
    @cursos = obtain_cursos @curso.tipo
    @secciones = obtain_seccion @curso.curso, @curso.tipo
  end

  # POST /cursos
  # POST /cursos.json
  def create
    @curso = Curso.new(params[:curso])
    respond_to do |format|
      if @curso.save
        format.html { redirect_to @curso, notice: 'El curso fue creado con exito.' }
        CustomLogger.info("Nuevo curso: #{@curso.curso.inspect} ,Nivel: #{@curso.nivel.inspect} ,Enfasis: #{@curso.enfasis.inspect} ,Turno:#{@curso.turno.inspect} creado por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @curso, status: :created, location: @curso }
      else
        @cursos = obtain_cursos @curso.tipo
        @secciones = obtain_seccion @curso.curso, @curso.tipo
        format.html { render action: "new" }
        CustomLogger.error("Error al crear un nuevo curso: #{@curso.curso.inspect} ,Nivel: #{@curso.nivel.inspect} ,Enfasis: #{@curso.enfasis.inspect} ,Turno:#{@curso.turno.inspect} por el usuario: #{current_user.full_name.inspect}, #{Time.now} ")
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cursos/1
  # PUT /cursos/1.json
  def update
    @curso = Curso.find(params[:id])
    curso_antiguo = @curso.curso
    nivel_antiguo = @curso.nivel
    enfasis_antiguo = @curso.enfasis
    turno_antiguo = @curso.turno
    respond_to do |format|
      if @curso.update_attributes(params[:curso])
        curso_nuevo = @curso.curso
        nivel_nuevo = @curso.nivel
        enfasis_nuevo = @curso.enfasis
        turno_nuevo = @curso.turno
        CustomLogger.info("Los datos antes de actualizar son: #{curso_antiguo.inspect}, Nivel: #{nivel_antiguo.inspect} ,Enfasis: #{enfasis_antiguo.inspect} ,Turno: #{turno_antiguo.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son: Curso: #{curso_nuevo.inspect} ,Nivel: #{nivel_nuevo.inspect} ,Enfasis:#{enfasis_nuevo.inspect} ,Turno:#{turno_nuevo.inspect}, #{Time.now}")
        format.html { redirect_to @curso, notice: 'El curso fue actualizado con exito' }
        format.json { head :no_content }
      else
        @cursos = obtain_cursos @curso.tipo
        @secciones = obtain_seccion @curso.curso, @curso.tipo
        format.html { render action: "edit" }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cursos/1
  # DELETE /cursos/1.json
  def destroy
    @curso = Curso.find(params[:id])
    @destruyo = false
    respond_to do |format|
      begin
        if @curso.destroy
           @destruyo = true
        end
        notice = "El curso y sus demas campos fueron eliminado correctamente."
        CustomLogger.info("Curso: #{@curso.curso.inspect} ,Nivel: #{@curso.nivel.inspect} ,Enfasis: #{@curso.enfasis.inspect} ,Turno:#{@curso.turno.inspect} eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      rescue
        notice = "Este curso no puede ser eliminado"
        CustomLogger.error("Curso: #{@curso.curso.inspect} y sus demas campos no pueden ser eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now} ")
      ensure
        format.html { redirect_to cursos_url }
        format.json { head :no_content }
        format.js
      end
    end
  end

  def change_select
    tipo = params[:tipo]
    curso_s = params[:curso]
    unless params[:id].empty?
      @curso = Curso.find(params[:id])
    else
      @curso = Curso.new
    end
    @cursos = obtain_cursos tipo
    @secciones = obtain_seccion curso_s, tipo
    respond_to do |format|
      format.js
    end
  end

  private
    def obtain_cursos tipo
      if tipo == "Grado"
        todos_cursos = ['Primer', 'Segundo', 'Tercer', 'Cuarto', 'Quinto', 'Sexto', 'Septimo', 'Octavo', 'Noveno' ]
      else 
        todos_cursos = ['Primer', 'Segundo', 'Tercer']
      end
      todos_cursos
    end

    def obtain_seccion curso_s, tipo
      curso_nombre = curso_s + " " + tipo
      todas_secciones = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L' ]
      cursos = Curso.by_year(Date.today.year).all
      secciones = []
      todas_secciones.each do |seccion|
        existe = false
        cursos.each do |curso|
          if curso.curso_grado_sin_seccion == curso_nombre
            if curso.seccion == seccion
              existe = true
            end
          end
        end
        unless existe
          secciones << seccion
        end
      end
      secciones
    end
end
