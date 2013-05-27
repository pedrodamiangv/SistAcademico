class SessionsController < ApplicationController

  def new
    flash[:error] = ""
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      flash[:error] = "No estan correctos los datos"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end

end
