class PuntajesController < ApplicationController
  before_filter :require_login
  before_filter :admin_user, only: [:destroy, :edit, :update, :new, :create]
  # GET /puntajes
  # GET /puntajes.json
  def index
    @puntajes = Puntaje.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @puntajes }
    end
  end

  # GET /puntajes/1
  # GET /puntajes/1.json
  def show
    @puntaje = Puntaje.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @puntaje }
    end
  end

  # GET /puntajes/new
  # GET /puntajes/new.json
  def new
    @puntaje = Puntaje.new
    atributos
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @puntaje }
    end
  end

  # GET /puntajes/1/edit
  def edit
    @puntaje = Puntaje.find(params[:id])
    atributos
  end

  # POST /puntajes
  # POST /puntajes.json
  def create
    @puntaje = Puntaje.new(params[:puntaje])

    respond_to do |format|
      if @puntaje.save
        format.html { redirect_to @puntaje, notice: 'Puntaje was successfully created.' }
        format.json { render json: @puntaje, status: :created, location: @puntaje }
      else
        atributos
        format.html { render action: "new" }
        format.json { render json: @puntaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /puntajes/1
  # PUT /puntajes/1.json
  def update
    @puntaje = Puntaje.find(params[:id])

    respond_to do |format|
      if @puntaje.update_attributes(params[:puntaje])
        format.html { redirect_to @puntaje, notice: 'Puntaje was successfully updated.' }
        format.json { head :no_content }
      else
        atributos
        format.html { render action: "edit" }
        format.json { render json: @puntaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /puntajes/1
  # DELETE /puntajes/1.json
  def destroy
    @puntaje = Puntaje.find(params[:id])
    @puntaje.destroy

    respond_to do |format|
      format.html { redirect_to puntajes_url }
      format.json { head :no_content }
    end
  end

  private
    def atributos
      @alumnos = Alumno.order('created_at desc').all
      @planificaciones = Planificacion.order('created_at desc').all
    end
end
