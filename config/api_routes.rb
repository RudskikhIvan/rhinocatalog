Rhinocatalog::Api::Engine.routes.draw do
	namespace :rhinocatalog, :path => '/' do
		namespace :api, :path => '/', :format => :json do
		    scope :v1 do
		        get 'docs' => 'documentations#show'
		        resources :users, only: [:create, :show] do
		            post :authorize, on: :collection
		            post :request_access, on: :collection
		        end            
		        resources :categories, only: [:index, :show]
		        resources :products, only: [:index, :show]
		    end
		end
	end
end