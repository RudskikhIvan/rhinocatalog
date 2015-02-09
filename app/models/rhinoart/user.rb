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

		# SAFE_INFO_ACCESSORS = [:locales]
		# store :info, accessors: SAFE_INFO_ACCESSORS, coder: JSON
		validates :name, presence: true

		ADMIN_PANEL_ROLE_CATALOG_MANAGER = "Catalog Manager"

		ADMIN_PANEL_ROLES.push(ADMIN_PANEL_ROLE_CATALOG_MANAGER)

		def locales=(value)
			value.reject! { |l| l.empty? }
			super
		end
	end
end
