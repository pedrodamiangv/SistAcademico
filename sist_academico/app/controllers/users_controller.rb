class UsersController < ApplicationController
  before_filter :require_login, :only => :secret

  def new
  	@user = User.new
    @cities_city = cities
    @addresses = Address.find(:all)
	end

	def create
	  @user = User.new(params[:user])
    @user.edad = calcular_edad @user
	  if @user.save
	    redirect_to root_url, :notice => "Signed up!"
	  else
      @addresses = Address.find(:all)
      @cities_city = cities
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

  private
    def cities
      cities_city = []
      cities = City.find(:all)
      cities.each do |city|
        cities_city << city.city
      end
      return cities_city
    end

    def calcular_edad user
      ano_nacimiento = user.fecha_nacimiento.slice(6,user.fecha_nacimiento.length);
      ano_actual = Date.today.to_s.slice(0,4);
      edad = ano_actual.to_i - ano_nacimiento.to_i;
      return edad;
    end

end
