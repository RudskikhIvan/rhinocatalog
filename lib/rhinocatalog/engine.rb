require 'rhinoart'
require 'rhinoart/utils'
require "rhinocatalog/ability"
require "rhinocatalog/user"

module Rhinocatalog
  class Engine < ::Rails::Engine
    isolate_namespace Rhinocatalog

    require "actionpack/action_caching" 


    initializer "rhinocatalog.init" do |app|

      Rhinoart::Menu::MainMenu.add_item({
        icon: 'fa-icon-shopping-cart',
        link: proc{ rhinocatalog.categories_path },
        label: 'rhinocatalog._CATALOG',
        allowed: proc{ can?(:manage, :catalog) },
        active: proc{ controller.class.name == 'Rhinocatalog::CategoriesController' || controller.class.name == 'Rhinocatalog::ProductsController' }
      })     

      ::Ability.send(:include, Rhinocatalog::Ability)
      Rhinoart::User.send(:include, Rhinocatalog::User)
    end
  end
end
