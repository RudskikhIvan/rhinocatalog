# == Schema Information
#
# Table name: rhinoart_users
#
#  id                     :integer          not null, primary key
#  name                   :string(250)
#  email                  :string(100)      not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  admin_role             :string(255)
#  frontend_role          :string(255)
#  approved               :boolean          default(FALSE), not null
#  info                   :text
#

require File.expand_path('../../app/models/rhinoart/user', Rhinoart::Engine.called_from)

module Rhinoart
	class User < ActiveRecord::Base
		before_validation :set_api_token
		after_initialize :split_api_role
		before_save :join_api_roles

		ADMIN_PANEL_ROLE_CATALOG_MANAGER = "Catalog Manager"
		ADMIN_PANEL_ROLES.push(ADMIN_PANEL_ROLE_CATALOG_MANAGER)

		API_ROLE_USER_MOBILE_APP = "Mobile Application User"
		API_ROLES = [API_ROLE_USER_MOBILE_APP]

		def locales=(value)
			value.reject! { |l| l.empty? }
			super
		end

		def has_access_to_api?
			res = false
			begin
				API_ROLES.each do |role|
					return (api_role.include? role) if (api_role.include? role) == true
				end
			rescue
				return false
			end

			return res
		end 

		private
			def set_api_token
				if api_token.blank?
					self.api_token = SecureRandom.hex(17) 
				end
			end

			def join_api_roles
				if self.api_role.kind_of?(Array)
					self.api_role.reject! { |ar| ar.empty? }
					self.api_role = self.api_role.join(',')
				end
			end

			def split_api_role
				self.api_role = self.api_role.split(',') if self.api_role.present?				
			end  

	end
end
