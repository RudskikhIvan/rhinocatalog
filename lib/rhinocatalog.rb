require "rhinoart/engine"
require "rhinocatalog/engine"

module Rhinocatalog
	extend ActiveSupport::Autoload
end

require 'rhinocatalog/railtie' if defined?(Rails)
