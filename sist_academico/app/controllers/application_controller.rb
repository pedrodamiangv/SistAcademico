class ApplicationController < ActionController::Base
  def not_authenticated
  	redirect_to login_url, :alert => "Primero necesitas hacer login."
  end

  def admin_user
    redirect_to(root_path) unless current_user.is_administrativo?
  end

  def calcular_edad user
      fecha_nacimiento = Date.strptime(user.fecha_nacimiento, "%d/%m/%Y")
      hoy = Date.today;
      edad = 0
      if (hoy.month >= fecha_nacimiento.month && hoy.day >= fecha_nacimiento.day)
        edad = hoy.year - fecha_nacimiento.year;
      else
        edad = hoy.year - fecha_nacimiento.year - 1;
      end
      return edad;
    end

end
