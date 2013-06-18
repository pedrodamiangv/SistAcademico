class MateriasController < ApplicationController
  before_filter :require_login
  before_filter :correct_user || :admin_user,   only: [:edit, :update, :show] 
  before_filter :admin_user,   only: [:new, :create, :destroy]
  # GET /materia
  # GET /materia.json
  def index
    @materias = Materia.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @materias }
    end
  end

  def materias_calificaciones
    @materia = Materia.find(params[:id])
    @puntaje_total_uno = @materia.planificaciones.where(:etapa => 'Primera').sum(:total_puntos)
    @calificaciones_etapa_uno = @materia.calificaciones.where(:etapa => 'Primera')
    @puntaje_total_dos = @materia.planificaciones.where(:etapa => 'Segunda').sum(:total_puntos)
    @calificaciones_etapa_dos = @materia.calificaciones.where(:etapa => 'Segunda')
    @puntaje_total_tres = @materia.planificaciones.where(:etapa => 'Tercera').sum(:total_puntos)
    @calificaciones_etapa_tres = @materia.calificaciones.where(:etapa => 'Tercera')
  end

  # GET /materia/1
  # GET /materia/1.json
  def show
    @materia = Materia.find(params[:id])
    @planificacion = @materia.planificaciones.build(params[:planificacion])
    @material = Material.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @materia }
    end
  end

  # GET /materia/new
  # GET /materia/new.json
  def new
    @materia = Materia.new
    @docentes = Docente.find(:all)
    @cursos = Curso.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @materia }
    end
  end

  def obtener_puntaje a, m, etapa
    planificaciones = m.planificaciones.where(:etapa => etapa)
    puntajes = 0
    planificaciones.each  do |p|
      ptjs = p.puntajes.where(:alumno_id => a.id)
      puntajes += ptjs.sum(:puntaje)
    end
    puntajes
  end

  def edit_auxiliar materia, etapa
    @puntaje_total = materia.planificaciones.where(:etapa => etapa).sum(:total_puntos)
    if materia.calificaciones.where(:etapa => etapa).count == 0
      @calificaciones = []
      materia.curso.alumnos.each do |alumno|
        calificacion = materia.calificaciones.build
        puntos_acumulados =  obtener_puntaje alumno, materia, etapa
        calificacion.puntos_correctos = puntos_acumulados
        calificacion.alumno = alumno
        @calificaciones << calificacion
      end
    else
      @calificaciones = materia.calificaciones
    end
  end

  def change_data
    @etapa = params[:select_etapa]
    @materia = Materia.find(params[:id])
    @docentes = Docente.find(:all)
    @cursos = Curso.find(:all)
    
    edit_auxiliar @materia, @etapa
    respond_to do |format|
      format.js
    end
  end

  # GET /materia/1/edit
  def edit
    @materia = Materia.find(params[:id])
    @docentes = Docente.find(:all)
    @cursos = Curso.find(:all)
    @etapa = 'Primera'
    
    edit_auxiliar @materia, @etapa
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /materia
  # POST /materia.json
  def create
    @materia = Materia.new(params[:materia])
    
    respond_to do |format|
      if @materia.save
        format.html { redirect_to @materia, notice: 'La materia ha sido registrada.' }
        format.json { render json: @materia, status: :created, location: @materia }
      else
        @docentes = Docente.find(:all)
        @cursos = Curso.find(:all)
        format.html { render action: "new" }
        format.json { render json: @materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /materia/1
  # PUT /materia/1.json
  def update
    @materia = Materia.find(params[:id])
    @etapa = params[:select_etapa]
    respond_to do |format|
      if @materia.update_attributes(params[:materia])
        format.html { redirect_to @materia, notice: 'La materia ha sido actualizada.' }
        format.json { head :no_content }
      else
        @docentes = Docente.find(:all)
        @cursos = Curso.find(:all)
        
        edit_auxiliar @materia, @etapa
        format.html { render action: "edit" }
        format.json { render json: @materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materia/1
  # DELETE /materia/1.json
  def destroy
    @materia = Materia.find(params[:id])
    @materia.destroy

    respond_to do |format|
      format.html { redirect_to materia_url }
      format.json { head :no_content }
    end
  end

  private
    def correct_user
      @materia = Materia.find(params[:id])
      if current_user.is_docente?
        redirect_to(root_path) unless ( @materia.docente == current_user.docente)
      elsif current_user.is_alumno?
        redirect_to(root_path) unless ( @materia.curso == current_user.alumno.curso )
      else
       redirect_to(root_path) unless ( current_user.is_administrativo?)
     end
    end
end
