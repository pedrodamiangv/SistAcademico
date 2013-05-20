class MateriasController < ApplicationController
  before_filter :require_login
  before_filter :admin_user, only: [:destroy, :edit, :update]
  # GET /materia
  # GET /materia.json
  def index
    @materias = Materia.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @materias }
    end
  end

  # GET /materia/1
  # GET /materia/1.json
  def show
    @materia = Materia.find(params[:id])

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

  # GET /materia/1/edit
  def edit
    @materia = Materia.find(params[:id])
    @docentes = Docente.find(:all)
    @cursos = Curso.find(:all)
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

    respond_to do |format|
      if @materia.update_attributes(params[:materia])
        format.html { redirect_to @materia, notice: 'La materia ha sido actualizada.' }
        format.json { head :no_content }
      else
        @docentes = Docente.find(:all)
        @cursos = Curso.find(:all)
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
end
