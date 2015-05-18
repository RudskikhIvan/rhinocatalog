Rhinocatalog::Engine.routes.draw do
    # devise_for :users, class_name: "Rhinoart::User", module: :devise, 
    #     :controllers => { :sessions => "rhinoart/sessions", :passwords => "rhinoart/passwords"  } 
        
	scope "(:locale)", locale: /ru|en/ do 
        root :to => 'categories#index'

		resources :categories do
			resources :products
		end	
        resources :images
	end

    # namespace :api do 
    #     scope :v1 do
    #         get 'docs' => 'documentations#show'
    #         resources :users, only: [:create, :show] do
    #             post :authorize, on: :collection
    #             post :request_access, on: :collection
    #         end            
    #         resources :categories, only: [:index, :show]
    #         resources :products, only: [:index, :show]
    #     end
    # end
end

