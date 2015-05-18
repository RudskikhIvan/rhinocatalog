require "rhinocatalog/api/engine"

module Rhinocatalog
	module Api
		class Engine < ::Rails::Engine
			paths["config/routes.rb"] = "config/api_routes.rb"
		end
	end
end
