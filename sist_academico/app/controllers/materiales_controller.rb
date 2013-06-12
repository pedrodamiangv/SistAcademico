class MaterialesController < ApplicationController

  def index
    @materiales = Material.paginate(:page => params[:page], :per_page => 10)
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
    respond_to do |format|
      if @material.save
        @materia = @material.materia
        format.js { render 'material_guardado' }
      else
        format.js { render 'material__no_guardado' }
      end
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy

    respond_to do |format|
      format.html { redirect_to materiales_url }
      format.js { render 'material_eliminado' }
    end
  end

  def download_file
    @material = Material.find(params[:id])
    send_file(@material.file.path,
          :disposition => 'attachment',
          :url_based_filename => false)
  end

end
