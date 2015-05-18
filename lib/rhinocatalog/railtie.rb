module Rhinocatalog
	class Railtie < Rails::Railtie

		VIEW_HELPERS_PATH = 'lib/rhinoart/view_helpers/'

		initializer "rhinocatalog_railtie.configure_rails_initialization" do |app|
			app.config.assets.precompile += %w( 
				rhinocatalog/*.css 
				rhinocatalog/*.js 
				fancybox/*.css 
				fancybox/*.js
				jquery.remotipart.js
		        swagger_ui.css
		        swagger_ui.js				
			)
		end

		initializer "rhinocatalog_railtie.configure_swagger" do |app|

			Swagger::Docs::Config.class_eval do

			  register_apis({
			      "1.0" => {
			          # the extension used for the API
			          :api_extension_type => :json,
			          # the output location where your .json files are written to
			          :api_file_path => 'public/api/swagger',
			          # the URL base path to your API
			          :base_path => 'http://localhost:3000/admin/catalog'
			      }
			  })

			  def self.base_application
			    Rhinocatalog::Engine
			  end

			  def self.transform_path(path, api_version)
			    "http://localhost:3000/api/swagger/#{path}"
			  end

			end

		end

	end
end

