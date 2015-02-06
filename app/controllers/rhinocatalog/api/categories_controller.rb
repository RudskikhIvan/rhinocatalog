require_dependency "rhinocatalog/application_controller"

module Rhinocatalog
	class Api::CategoriesController < Api::BaseController
		def index
			render json: Category.where(published: true)
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
