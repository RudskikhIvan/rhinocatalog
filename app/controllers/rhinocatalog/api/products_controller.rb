require_dependency "rhinocatalog/application_controller"

module Rhinocatalog
	class Api::ProductsController < Api::BaseController
	    def index
	    	render json: Product.where(published: true)
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
