module ApplicationHelper
  class ActionView::Helpers::FormBuilder
	def inputbox_field(method, options = {})
	  text_field(method, options.merge(id: 'chico'))
	end
  end
end
