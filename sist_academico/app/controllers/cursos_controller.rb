require 'custom_logger'
class CursosController < ApplicationController
  before_filter :require_login
  before_filter :admin_user, only: [:destroy, :edit, :update, :new, :create]
 

  def index_total
    @cursos = Curso.paginate(:page => params[:page], :per_page => 10)
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
    @cursos = Curso.by_year(Date.today.year).paginate(:page => params[:page], :per_page => 10)
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @curso }
    end
  end

  # GET /cursos/1/edit
  def edit
    @curso = Curso.find(params[:id])
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
        format.html { render action: "edit" }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cursos/1
  # DELETE /cursos/1.json
  def destroy
    @curso = Curso.find(params[:id])
    respond_to do |format|
      begin
        @curso.destroy
        notice = "El curso y sus demas campos fueron eliminado correctamente."
        CustomLogger.info("Curso: #{@curso.curso.inspect} ,Nivel: #{@curso.nivel.inspect} ,Enfasis: #{@curso.enfasis.inspect} ,Turno:#{@curso.turno.inspect} eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      rescue
        notice = "Este curso no puede ser eliminado"
        CustomLogger.error("Curso: #{@curso.curso.inspect} y sus demas campos no pueden ser eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now} ")
      ensure
        format.html { redirect_to cursos_url }
        format.json { head :no_content }
      end
    end
  end
end
