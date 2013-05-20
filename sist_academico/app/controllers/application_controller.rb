class ApplicationController < ActionController::Base
  def not_authenticated
  	redirect_to login_url, :alert => "Primero necesitas hacer login."
  end

  def admin_user
    redirect_to(root_path) unless current_user.is_administrativo?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless (current_user == @user)
  end

end
