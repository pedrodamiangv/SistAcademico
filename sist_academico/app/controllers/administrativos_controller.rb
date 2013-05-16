class AdministrativosController < ApplicationController
  # GET /administrativos
  # GET /administrativos.json
  def index
    @administrativos = Administrativo.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @administrativos }
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
    @administrativo = Administrativo.new
    @users = User.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @administrativo }
    end
  end

  # GET /administrativos/1/edit
  def edit
    @administrativo = Administrativo.find(params[:id])
    @users = User.find(:all)
  end

  # POST /administrativos
  # POST /administrativos.json
  def create
    @administrativo = Administrativo.new(params[:administrativo])
    user = @administrativo.user
    respond_to do |format|
      if @administrativo.save
        user.administrativo = @administrativo
        user.update_attribute(:is_administrativo, true )
        format.html { redirect_to @administrativo, notice: 'El administrativo ha sido creado.' }
        format.json { render json: @administrativo, status: :created, location: @administrativo }
      else
        @users = User.find(:all)
        format.html { render action: "new" }
        format.json { render json: @administrativo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /administrativos/1
  # PUT /administrativos/1.json
  def update
    @administrativo = Administrativo.find(params[:id])

    respond_to do |format|
      if @administrativo.update_attributes(params[:administrativo])
        format.html { redirect_to @administrativo, notice: 'El administrativo ha sido actualizado.' }
        format.json { head :no_content }
      else
        @users = User.find(:all)
        format.html { render action: "edit" }
        format.json { render json: @administrativo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrativos/1
  # DELETE /administrativos/1.json
  def destroy
    @administrativo = Administrativo.find(params[:id])
    @administrativo.destroy

    respond_to do |format|
      format.html { redirect_to administrativos_url }
      format.json { head :no_content }
    end
  end
end
