require_dependency "rhinocatalog/application_controller"

module Rhinocatalog
	class Api::ProductsController < Api::BaseController
		swagger_controller :products, "Products"

		swagger_api :index do
			summary "Fetches all Product items"
			param :query, :api_token, :string, :required, "Api Token"
			response :unauthorized, Rhinocatalog::Api::ERROR_ACCESS_DENIED
			response :unauthorized, Rhinocatalog::Api::ERROR_ACCESS_DENIED_INVALID_API_TOKEN
			response :unauthorized, Rhinocatalog::Api::ERROR_ACCESS_DENIED_USER_WASNT_APPROVED
			response 403, Rhinocatalog::Api::ERROR_ACCESS_DENIED_USER_HAS_NO_ACCESS_RIGHT
			response :requested_range_not_satisfiable, Rhinocatalog::Api::ERROR_PARAM_TYPE
		end	
	    def index
	    	render json: Product.where(published: true)
	    end

		swagger_api :show do
			summary "Fetches a single Product item"
			param :path, :id, :integer, :required, "Product id"
			param :query, :api_token, :string, :required, "Api Token"
			response :unauthorized, Rhinocatalog::Api::ERROR_ACCESS_DENIED
			response :unauthorized, Rhinocatalog::Api::ERROR_ACCESS_DENIED_INVALID_API_TOKEN
			response :unauthorized, Rhinocatalog::Api::ERROR_ACCESS_DENIED_USER_WASNT_APPROVED
			response 403, Rhinocatalog::Api::ERROR_ACCESS_DENIED_USER_HAS_NO_ACCESS_RIGHT
			response :requested_range_not_satisfiable, Rhinocatalog::Api::ERROR_PARAM_TYPE
		end	
	    def show
			begin
				render json: Product.find(params[:id])
			rescue Exception => e
				raise NotFoundError.new
			end			
	    end
	end
end
