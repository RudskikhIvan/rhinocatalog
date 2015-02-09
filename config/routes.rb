Rhinocatalog::Engine.routes.draw do
    devise_for :users, class_name: "Rhinoart::User", module: :devise, 
        :controllers => { :sessions => "rhinoart/sessions", :passwords => "rhinoart/passwords"  } 
        
	scope "(:locale)", locale: /ru|en/ do 
        root :to => 'categories#index'

		resources :categories do
			resources :products
		end	
        resources :images
	end

    namespace :api do 
        scope :v1 do
            resources :categories, only: [:index, :show]
            resources :products, only: [:index, :show]
        end
    end
end

