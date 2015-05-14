require_dependency "rhinocatalog/application_controller"

module Rhinocatalog
	class Api::CategoriesController < Api::BaseController
		swagger_controller :categories, "Categories"

		swagger_api :index do
			summary "Fetches all Category items"
			param :query, :api_token, :string, :required, "Api Token"
			response :unauthorized, Api::ERROR_ACCESS_DENIED
			response :unauthorized, Api::ERROR_ACCESS_DENIED_INVALID_API_TOKEN
			response :unauthorized, Api::ERROR_ACCESS_DENIED_USER_WASNT_APPROVED
			response 403, Api::ERROR_ACCESS_DENIED_USER_HAS_NO_ACCESS_RIGHT
			response :requested_range_not_satisfiable, Api::ERROR_PARAM_TYPE
		end			
		def index
			render json: Category.where(published: true)
		end

		swagger_api :show do
			summary "Fetches single Category item"
			param :path, :id, :integer, :required, "Product id"
			param :query, :api_token, :string, :required, "Api Token"
			response :unauthorized, Api::ERROR_ACCESS_DENIED
			response :unauthorized, Api::ERROR_ACCESS_DENIED_INVALID_API_TOKEN
			response :unauthorized, Api::ERROR_ACCESS_DENIED_USER_WASNT_APPROVED
			response 403, Api::ERROR_ACCESS_DENIED_USER_HAS_NO_ACCESS_RIGHT
			response :requested_range_not_satisfiable, Api::ERROR_PARAM_TYPE
		end	
		def show
			begin
				render json: Category.find(params[:id])
			rescue Exception => e
				raise NotFoundError.new
			end			
		end
	end
end
