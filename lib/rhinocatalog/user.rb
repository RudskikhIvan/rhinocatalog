module Rhinocatalog
	module User
		extend ActiveSupport::Concern		

		included do
			before_validation :set_api_token
			before_save :update_api_roles
			
			attr_accessor :api_roles, :api_roles_changed

			Rhinoart::User::ADMIN_PANEL_ROLE_CATALOG_MANAGER = "Catalog Manager"
			Rhinoart::User::ADMIN_PANEL_ROLES << Rhinoart::User::ADMIN_PANEL_ROLE_CATALOG_MANAGER

			Rhinoart::User::API_ROLE_USER_MOBILE_APP = "Mobile Application User"
			Rhinoart::User::API_ROLES = [Rhinoart::User::API_ROLE_USER_MOBILE_APP]
		end

		def has_access_to_api?
			Rhinoart::User::API_ROLES.each do |role|
				return (api_role.include? role) if api_role.present?
			end
			return false
		end 

		private
			def set_api_token
				if api_token.blank?
					self.api_token = SecureRandom.hex(17)
				end
			end

	        def update_api_roles
	        	clear_roles Rhinoart::User::API_ROLES if api_roles_changed.present? && api_roles_changed

	            if api_roles.present? && api_roles.any?	                
	                api_roles.each do |r| 
	                    self.add_role r 
	                end 
	            end
	        end
	end
end