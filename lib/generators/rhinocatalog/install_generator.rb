module Rhinocatalog

  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)
    desc "Installs Rhinocatalog and run migrations"

    def copy_files
      # copy_file "controllers/galleries_controller.rb", "app/controllers/galleries_controller.rb"
      # copy_file "views/index.html.haml", "app/views/galleries/index.html.haml"
      # copy_file "views/show.html.haml", "app/views/galleries/show.html.haml"
    end

    def install_migrations
      rake 'rhinocatalog:install:migrations'
    end

    def run_migrations
      rake 'db:migrate'
    end

    def install_routes      
      route "mount Rhinocatalog::Engine => '/admin/catalog'"
    end

  end

end