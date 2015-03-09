require_dependency "rhinocatalog/application_controller"

module Rhinocatalog
	class BaseController < Rhinoart::BaseController
		# before_action :set_locale
		before_action { authorize! :manage, :catalog }

		def default_url_options(options={})
			if I18n.locale != I18n.default_locale
				{ locale: I18n.locale }
			else
				{ locale: nil }
			end
		end		
	end
end
