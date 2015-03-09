require 'rhinoart'

module Rhinocatalog
  class Engine < ::Rails::Engine
    isolate_namespace Rhinocatalog

    require "actionpack/action_caching" 


    initializer "rhinocatalog.add_menu_item" do |app|

      Rhinoart::Menu::MainMenu.add_item({
        icon: 'fa-icon-shopping-cart',
        link: proc{ rhinocatalog.categories_path },
        label: 'rhinocatalog._CATALOG',
        allowed: proc{ can?(:manage, :catalog) },
        active: proc{ controller_name == 'categories' }
      })            
    end
  end
end
