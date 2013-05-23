class UsersController < ApplicationController
  before_filter :require_login
  before_filter :admin_user
  before_filter :correct_user,   only: [:edit, :update, :show]

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def new
  	@user = User.new
    @cities_city = cities
    @addresses = Address.find(:all)
    addresses_new
	end

	def create
	  @user = User.new(params[:user])
    @user.edad = calcular_edad @user
	  if @user.save
	    redirect_to root_url, :notice => "Signed up!"
	  else
      @addresses = Address.find(:all)
      @cities_city = cities
      addresses_new
      render :new
	  end
	end

	def edit
    @user = User.find(params[:id])
    @cities_city = cities
    @addresses = Address.find(:all)
    addresses_new
  end

  def update
    @user = User.new (params[:user])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      @cities_city = cities
      @addresses = Address.find(:all)
      addresses_new
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def addresses_new
      @direccion = Address.new
      @cities = City.find(:all)
    end

  def self.addresses_create
      @direccion = Address.new(params[:direccion])
      if @direccion.save
        flash[:notice] = "Guardado"
        return true
      else
        flash[:notice] = "Hubo Problemas, no guardo"
        return false
      end
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
