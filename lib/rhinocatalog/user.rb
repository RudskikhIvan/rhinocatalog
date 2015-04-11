module Rhinocatalog
	module User
		extend ActiveSupport::Concern		

		included do
			before_validation :set_api_token

			Rhinoart::User::ADMIN_PANEL_ROLE_CATALOG_MANAGER = "Catalog Manager"
			Rhinoart::User::ADMIN_PANEL_ROLES << Rhinoart::User::ADMIN_PANEL_ROLE_CATALOG_MANAGER

			Rhinoart::User::API_ROLE_USER_MOBILE_APP = "Mobile Application User"
			Rhinoart::User::API_ROLES = [Rhinoart::User::API_ROLE_USER_MOBILE_APP]
		end

	    def has_access_to_api?
	        Rhinoart::User::API_ROLES.each do |role|
	            res = has_role? role
	            return res if res == true
	        end
	        false
	    end
		private
			def set_api_token
				if api_token.blank?
					self.api_token = SecureRandom.hex(17)
				end
			end

	end
end