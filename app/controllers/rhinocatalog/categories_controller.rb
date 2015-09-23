require_dependency "rhinocatalog/application_controller"

module Rhinocatalog
	class CategoriesController < BaseController
		before_action :set_category, only: [:edit, :update, :destroy]

		def index
			@categories = Category.tree #paginate(:page => params[:page])
		end

		def new
			@category = Category.new
		end

		def create
			@category = Category.new(category_params)

			if @category.save
				redirect_to :categories
			else
				render action: 'new'
			end			
		end

		def edit
		end

		def update
			if @category.update(category_params)
				redirect_to :categories
			else
				render action: 'edit'
			end			
		end

		def destroy
			@category.destroy
			redirect_to :categories			
		end

		private
			# Use callbacks to share common setup or constraints between actions.
			def set_category
				begin
					@category = Category.find(params[:id])
				rescue
					render :template => 'site/not_found', :status => 404
				end
			end

			# Only allow a trusted parameter "white list" through.
			def category_params
				params[:category].permit!
			end
	end
end
