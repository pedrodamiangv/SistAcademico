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
    @addresses = Address.order("created_at desc").find(:all)
    addresses_new
	end

	def create
	  @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        @user.edad = calcular_edad @user
        user.update_attribute(:edad, edad )
        format.html { redirect_to @user, notice: 'El Usuario ha sido registrado.' }
        format.json { render json: @user, status: :created, location: @user }
        format.js   {}
      else
        @addresses = Address.order("created_at desc").find(:all)
        @cities_city = cities
        addresses_new
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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

  private
    def cities
      cities_city = []
      cities = City.find(:all)
      cities.each do |city|
        cities_city << city.city
      end
      return cities_city
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless (current_user == @user || current_user.is_administrativo?)
    end

end
