class StaticPagesController < ApplicationController
  before_filter :require_login, :only => :secret
  def home
  end

  def help
  end

  def about
  end

  def contact
  end
end
