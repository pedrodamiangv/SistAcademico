class AlumnosController < ApplicationController
  before_filter :require_login
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
    @cursos = Curso.find(:all)
    @users = User.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alumno }
    end
  end

  # GET /alumnos/1/edit
  def edit
    @alumno = Alumno.find(params[:id])
    @cursos = Curso.find(:all)
    @users = User.find(:all)
  end

  # POST /alumnos
  # POST /alumnos.json
  def create
    @alumno = Alumno.new(params[:alumno])
    user = @alumno.user
    respond_to do |format|
      if @alumno.save
        user.alumno = @alumno
        user.update_attribute(:is_alumno, true )
        format.html { redirect_to @alumno, notice: 'El alumno ha sido registrado.' }
        format.json { render json: @alumno, status: :created, location: @alumno }
      else
        @cursos = Curso.find(:all)
        @users = User.find(:all)
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
        @cursos = Curso.find(:all)
        @users = User.find(:all)
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
end
