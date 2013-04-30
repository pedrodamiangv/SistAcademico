class UsersController < ApplicationController
  before_filter :require_login, :only => :secret
  def new
  	@user = User.new
    @cities = City.find(:all)
    @addresses = Address.find(:all)
	end

	def create
	  @user = User.new(params[:user])
	  if @user.save
	    redirect_to root_url, :notice => "Signed up!"
	  else
	    render :new
	  end
	end

	def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
