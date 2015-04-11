module Rhinocatalog
	module User
		extend ActiveSupport::Concern

		included do
			before_validation :set_api_token

			Rhinoart::User::ADMIN_PANEL_ROLE_CATALOG_MANAGER = "Catalog Manager"
			Rhinoart::User::ADMIN_PANEL_ROLES << Rhinoart::User::ADMIN_PANEL_ROLE_CATALOG_MANAGER

			Rhinoart::User::API_ROLE_USER_MOBILE_APP = "Mobile Application User"
			Rhinoart::User::API_ROLES = [Rhinoart::User::API_ROLE_USER_MOBILE_APP]

			Rhinoart::User::SAFE_INFO_ACCESSORS = [:street, :city, :state, :zip, :interest_level]
			Rhinoart::User::store :info, accessors: Rhinoart::User::SAFE_INFO_ACCESSORS, coder: JSON    
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
	end
end