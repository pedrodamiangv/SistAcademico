class SessionsController < ApplicationController

  def new
    flash[:error] = ""
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      root = obtain_preference "last_page", user
      if root 
        redirect_to root.value
      else
        redirect_back_or_to root_url, :notice => "Se ha logueado correctamente!"
      end
    else
      flash[:error] = "No estan correctos los datos"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Se ha cerrado la sesion"
  end

  private
    def obtain_preference cod, user
      preference = Preferencia.where("codigo = ? AND user_id = ?",cod,user.id).first
    end

end
