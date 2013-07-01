require 'custom_logger'
class MateriasController < ApplicationController
  before_filter :require_login
  before_filter :correct_user_for_show || :admin_user,   only: [:show] 
  before_filter :correct_user || :admin_user,   only: [:edit, :update] 
  before_filter :admin_user,   only: [:new, :create, :destroy]
  # GET /materia
  # GET /materia.json

  def index_total
    @materias = Materia.order('created_at DESC').all
    @total = true
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @materias }
      format.pdf { render 'index', :layout => false }
    end

  end

  # GET /cursos
  # GET /cursos.json
  def index
    @materias = Materia.by_year(Date.today.year).all
    @total = false
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @materias }
      format.pdf { render :layout => false }
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
      format.pdf { render :layout => false }
    end
  end

  # GET /materia/new
  # GET /materia/new.json
  def new
    @materia = Materia.new
    @docentes = Docente.order('created_at desc').all
    @cursos = Curso.by_year(Date.today.year).all
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
    @docentes = Docente.order('created_at desc').all
    @cursos = Curso.by_year(Date.today.year).all
    
    edit_auxiliar @materia, @etapa
    respond_to do |format|
      format.js
    end
  end

  # GET /materia/1/edit
  def edit
    @materia = Materia.find(params[:id])
    @docentes = Docente.order('created_at desc').all
    @cursos = Curso.by_year(Date.today.year).all
    @etapa = 'Primera'
    
    edit_auxiliar @materia, @etapa
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit_campos
    @materia = Materia.find(params[:id])

    @docentes = Docente.order('created_at desc').all
    @cursos = Curso.by_year(Date.today.year).all
    respond_to do |format|
      format.html 
      format.json { render json: @materia }
    end
  end

  # POST /materia
  # POST /materia.json
  def create
    @materia = Materia.new(params[:materia])
    
    respond_to do |format|
      if @materia.save
        format.html { redirect_to @materia, notice: 'La materia ha sido creada con exito.' }
        CustomLogger.info("Nueva materia: #{@materia.materia.inspect} ,Area: #{@materia.area.inspect} ,Curso: #{@materia.curso_curso.inspect} ,Docente: #{@materia.docente.full_name.inspect} creado por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @materia, status: :created, location: @materia }
      else
        @docentes = Docente.order('created_at desc').all
        @cursos = Curso.by_year(Date.today.year).all
        format.html { render action: "new" }
        CustomLogger.error("Error al crear materia: #{@materia.materia.inspect} ,Area: #{@materia.area.inspect} ,Curso: #{@materia.curso_curso.inspect} ,Docente: #{@materia.docente.full_name.inspect} por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.json { render json: @materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /materia/1
  # PUT /materia/1.json
  def update
    @materia = Materia.find(params[:id])
    materia_antigua = @materia.materia
    area_antiguo = @materia.area
    curso_antiguo = @materia.curso_curso
    docente_antiguo = @materia.docente.full_name
    @etapa = params[:select_etapa]
    set_direccion
    respond_to do |format|
      if @materia.update_attributes(params[:materia])
        materia_nueva = @materia.materia
        area_nueva = @materia.area
        curso_nuevo = @materia.curso_curso
        docente_nuevo = @materia.docente.full_name
        CustomLogger.info("Los datos antes de actualizar son: Materia: #{materia_antigua.inspect} ,Area:#{area_antiguo.inspect} ,Curso:#{curso_antiguo.inspect} ,Docente:#{docente_antiguo.inspect} .Los datos actualizados por el usuario: #{current_user.full_name.inspect} son: #{materia_nueva.inspect} ,Area:#{area_nueva.inspect} ,Curso:#{curso_nuevo.inspect} ,Docente:#{docente_nuevo.inspect}, #{Time.now}")
        format.html { redirect_to @materia, notice: 'La materia ha sido actualizada correctamente.' }
        format.json { head :no_content }
      else
        @docentes = Docente.order('created_at desc').all
        @cursos = Curso.by_year(Date.today.year).all
        
        edit_auxiliar @materia, @etapa
        format.html { render action: "#{@@dir}" }
        format.json { render json: @materia.errors, status: :unprocessable_entity }
      end
    end
  end

  @@dir
  def set_direccion
    if current_user.preferencias.first.value.split('/').last == "edit" || current_user.preferencias.first.value.split('/').last == "edit_campos"
      @@dir = current_user.preferencias.first.value.split('/').last
    end
  end

  # DELETE /materia/1
  # DELETE /materia/1.json
  def destroy
    @materia = Materia.find(params[:id])
    @destruyo = false
    respond_to do |format|
      begin
        if @materia.destroy
           @destruyo = true
        end
        notice = "La materia ha sido eliminado correctamente"
        CustomLogger.info("Materia: #{@materia.materia.inspect} ,Area: #{@materia.area.inspect} ,Curso: #{@materia.curso_curso.inspect} ,Docente: #{@materia.docente.full_name.inspect} han sido eliminados por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
      rescue
        notice = "Esta materia y sus demas campos no pueden ser eliminados"
        CustomLogger.error("Error al eliminar la materia: #{@materia.materia.inspect} y sus demas campos, por el usuario: #{current_user.full_name.inspect}, #{Time.now}" )
      ensure
        format.html { redirect_to materias_url, notice: notice }
        format.json { head :no_content }
        format.js
      end
    end
  end

  private
    def correct_user_for_show
      @materia = Materia.find(params[:id])
      if current_user.is_docente?
        redirect_to(root_path) unless ( @materia.docente == current_user.docente)
      elsif current_user.is_alumno?
        redirect_to(root_path) unless ( @materia.curso == current_user.alumno.curso )
      else
       redirect_to(root_path) unless ( current_user.is_administrativo?)
     end
    end

    def correct_user
      @materia = Materia.find(params[:id])
      if current_user.is_administrativo?

      elsif current_user.is_docente?
        redirect_to(root_path) unless ( @materia.docente == current_user.docente)
      elsif current_user.is_alumno?
        redirect_to(root_path) 
     end
    end
end
