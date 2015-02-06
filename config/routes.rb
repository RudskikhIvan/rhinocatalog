Rhinocatalog::Engine.routes.draw do
    # devise_for :users, class_name: "Rhinoart::User", module: :devise, 
    #     :controllers => { :sessions => "rhinoart/sessions", :passwords => "rhinoart/passwords"  } 
        
	scope "(:locale)", locale: /ru|en/ do 
		root :to => 'categories#index'

		resources :categories do
			resources :products
		end	
	end

    #API
    namespace :api do
      scope :v1 do
        resources :categories, only: [:index, :show] do 
        	resources :products, only: [:index, :show]
        end
      end
    end
end
