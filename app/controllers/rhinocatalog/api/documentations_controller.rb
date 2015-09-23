require_dependency "rhinocatalog/application_controller"

module Rhinocatalog
	class Api::DocumentationsController < ApplicationController

		# before_filter :generate_docs_in_development

		def show
			render :show, :layout => false
		end

		def generate_docs_in_development
			return unless Rails.env.development?
			Swagger::Docs::Generator.write_docs(Swagger::Docs::Config.registered_apis)
		end

		def self.basic_auth_config
			@basic_auth_config = (YAML.load_file(Rails.root.join('config/basic_auth.yml')).symbolize_keys rescue nil) || {
			:name => 'api',
			:password => 'apipass'
			}
		end
		http_basic_authenticate_with self.basic_auth_config
	end
end


