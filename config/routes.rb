Rhinocatalog::Engine.routes.draw do
  get "products/new"
  get "products/create"
  get "products/edit"
  get "products/update"
  get "products/destroy"
  get "categories/new"
  get "categories/create"
  get "categories/edit"
  get "categories/update"
  get "categories/destroy"
    # devise_for :users, class_name: "Rhinoart::User", module: :devise, 
    #     :controllers => { :sessions => "rhinoart/sessions", :passwords => "rhinoart/passwords"  } 
        
	scope "(:locale)", locale: /ru|en/ do 
		root :to => 'categories#index'

		resources :categories do
			resources :products
		end	
	end

    #API
    # namespace :api do
    #   scope :v1 do
    #     resources :temp_contents, only: [:show]
    #   end
    # end
end
