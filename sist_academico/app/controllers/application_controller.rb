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

  def self.save_preference cod, user, value
    if user
      preference = Preferencia.where("codigo = ? AND user_id = ?",cod,user.id.to_s).first 
      if preference
        preference.update_attribute(:value, value.to_s)
      else
        preference = Preferencia.new
        preference.codigo = cod
        preference.user = user
        preference.value = value.to_s
        preference.save
      end
    end
  end

  def self.obtener_noticias
    noticias = Noticia.all
  end
end
