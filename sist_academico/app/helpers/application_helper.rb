module ApplicationHelper
  class ActionView::Helpers::FormBuilder
	def inputbox_field(method, options = {})
	  text_field(method, options.merge(id: 'chico'))
	end
  end

  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end
  
end
