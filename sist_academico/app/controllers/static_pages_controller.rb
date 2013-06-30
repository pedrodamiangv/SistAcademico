class StaticPagesController < ApplicationController
  before_filter :require_login
  def home
  	@noticias = ApplicationController.obtener_noticias
  end

  def help
  end

  def about
  end

  def contact
  end
end
