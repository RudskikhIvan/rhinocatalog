module Rhinocatalog
  class Railtie < Rails::Railtie

    VIEW_HELPERS_PATH = 'lib/rhinoart/view_helpers/'

    initializer "rhinocatalog_railtie.configure_rails_initialization" do |app|
      app.config.assets.precompile += %w( rhinocatalog/*.js fancybox/*.css fancybox/*.js )
    end
  end
end

