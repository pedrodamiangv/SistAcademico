class NoticiasController < ApplicationController

	def new
    @noticia = Noticia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @noticia }
    end
  end

  # GET /cities/1/edit
  def edit
    @noticia = Noticia.find(params[:id])
  end

  # POST /cities
  # POST /cities.json
  def create
    @noticia = Noticia.new (params[:noticia])
    @noticia.user = current_user
    respond_to do |format|
      if @noticia.save
      	@noticias = Noticia.order("created_at DESC").all
        CustomLogger.info("Nueva noticia: #{@noticia.noticia.inspect} creada por #{current_user.full_name.inspect}, #{Time.now}")
        format.js 
      else
        CustomLogger.error("Error al crear noticia: #{@noticia.noticia.inspect}. Usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.js { render 'create_error' }
      end
    end
  end

  # PUT /cities/1
  # PUT /cities/1.json
  def update
    @noticia = Noticia.find(params[:id])
    noticia_antigua = @noticia.noticia
    respond_to do |format|
      if @noticia.update_attributes(params[:noticia])
      	@noticias = Noticia.order("created_at DESC").all
        noticia_nueva = @noticia.noticia
        CustomLogger.info("Los datos antes de actualizar son: Noticia #{noticia_antigua.inspect}. Los datos actualizados por el usuario: #{current_user.full_name.inspect} son: Noticia #{noticia_nueva.inspect}, #{Time.now}")
        format.js { 'create' }
      else
        format.js { render 'create_error' }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @noticia = Noticia.find(params[:id])
    respond_to do |format|
      begin
        @noticia.destroy
        notice= "La noticia ha sido eliminada"
        CustomLogger.info("Noticia #{@noticia.noticia.inspect} eliminada por #{current_user.full_name.inspect}, #{Time.now}")
      rescue
        notice= "Esta noticia no puede ser eliminada"
        Custom+Logger.error("Error al eliminar la noticia: #{@noticia.noticia.inspect}. Usuario: #{current_user.full_name.inspect}, #{Time.now}")
      ensure
        format.js
      end
    end
  end

end

