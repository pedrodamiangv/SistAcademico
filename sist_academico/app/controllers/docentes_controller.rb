class DocentesController < ApplicationController
  before_filter :require_login
  # GET /docentes
  # GET /docentes.json
  def index
    @docentes = Docente.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @docentes }
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
    @docente = Docente.new
    @users = User.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @docente }
    end
  end

  # GET /docentes/1/edit
  def edit
    @docente = Docente.find(params[:id])
    @users = User.find(:all)
  end

  # POST /docentes
  # POST /docentes.json
  def create
    @docente = Docente.new(params[:docente])
    user = @docente.user
    respond_to do |format|
      if @docente.save
        user.docente = @docente
        user.update_attribute(:is_docente, true )
        format.html { redirect_to @docente, notice: 'El Docente ha sido guardado.' }
        format.json { render json: @docente, status: :created, location: @docente }
      else
        @users = User.find(:all)
        format.html { render action: "new" }
        format.json { render json: @docente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /docentes/1
  # PUT /docentes/1.json
  def update
    @docente = Docente.find(params[:id])

    respond_to do |format|
      if @docente.update_attributes(params[:docente])
        format.html { redirect_to @docente, notice: 'El docente ha sido actualizado.' }
        format.json { head :no_content }
      else
        @users = User.find(:all)
        format.html { render action: "edit" }
        format.json { render json: @docente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docentes/1
  # DELETE /docentes/1.json
  def destroy
    @docente = Docente.find(params[:id])
    @docente.destroy

    respond_to do |format|
      format.html { redirect_to docentes_url }
      format.json { head :no_content }
    end
  end
end
