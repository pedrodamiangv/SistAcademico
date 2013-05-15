class ApplicationController < ActionController::Base
  def not_authenticated
  	redirect_to login_url, :alert => "Primero necesitas hacer login."
  end
end
