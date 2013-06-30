require 'custom_logger'
class MaterialesController < ApplicationController

  def index
    @materiales = Material.order('created_at DESC').all
  end

  def show
    @material = Material.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @material }
    end
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(params[:material])
    @materia = @material.materia
    respond_to do |format|
      if @material.save
        @materia = @material.materia
        format.html { redirect_to @materia }
        CustomLogger.info("Un nuevo material #{@material.file.inspect} se ha subido en la materia: #{@material.materia_materia.inspect} por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
        format.js { render 'material_guardado' }
      else
        format.js { render 'material_no_guardado' }
      end
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy

    respond_to do |format|
      format.html { redirect_to materiales_url }
      format.js { render 'material_eliminado' }
      CustomLogger.info("Material #{@material.file.inspect} almacenado en la materia: #{@material.materia_materia.inspect} ha sido eliminado por el usuario: #{current_user.full_name.inspect}, #{Time.now}")
    end
  end

  def download_file
    @material = Material.find(params[:id])
    send_file(@material.file.path,
          :disposition => 'attachment',
          :url_based_filename => false)
  end

end
