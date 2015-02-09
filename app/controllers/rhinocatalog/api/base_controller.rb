require_dependency "rhinocatalog/application_controller"

module Rhinocatalog
	class Api::BaseController < ApplicationController
	    # include ApplicationHelper
	    # before_filter :check_if_user_has_access_to_api
	    # caches_action :index, :show, expires_in: 10.minutes, :cache_path => Proc.new { |c| "#{c.params}" }

	    

	    class InvalidAccessRightError < StandardError; end
	    class InvalidApiKeyError < StandardError; end
	    class InvalidParametersError < StandardError; end
	    class UserNotApprovedError < StandardError; end    
	    class NotFoundError < StandardError; end
	    class DomainNotFoundError < StandardError; end

	    rescue_from InvalidAccessRightError do |exception|
	        render json: {message: "Access Denied (user has no access right)", error_code: Rhinocatalog::Api::ERROR_ACCESS_DENIED_USER_HAS_NO_ACCESS_RIGHT}, status: :unauthorized
	    end

	    rescue_from InvalidApiKeyError do |exception|
	        render json: {message: "Access Denied (invalid API token)", error_code: Rhinocatalog::Api::ERROR_ACCESS_DENIED_INVALID_API_TOKEN}, status: :unauthorized
	    end

	    rescue_from InvalidParametersError do |exception|
	        render json: {message: "Invalid input parameters", error_code: Rhinocatalog::Api::ERROR_PARAM_TYPE}, status: 404
	    end

	    rescue_from UserNotApprovedError do |exception|
	        render json: {message: "Access Denied (user wasn't approved)", error_code: Rhinocatalog::Api::ERROR_ACCESS_DENIED_USER_WASNT_APPROVED}, status: :unauthorized
	    end

	    rescue_from NotFoundError do |exception|
	      render json: {message: "Content Not Found - 404", error_code: Rhinocatalog::Api::ERROR_CONTENT_NOT_FOUND}, status: 404
	    end

	    rescue_from DomainNotFoundError do |exception|
	      render json: {message: "Domain Not Found or IP-address wrong", error_code: Rhinocatalog::Api::ERROR_DOMAIN_NOT_FOUND}, status: :unprocessable_entity
	    end

	    private
	        def check_if_user_has_access_to_api

	            # if user_signed_in?
	            #     @api_user = current_user
	            # else
	            #     @api_user = User.find_by(api_token: params[:api_token])
	            # end

	            # if @api_user.nil?
	            #     raise InvalidApiKeyError.new
	            # end

	            # unless @api_user.approved
	            #     raise UserNotApprovedError.new
	            # end

	            # if !@api_user.has_access_to_api? #&& !user_signed_in?
	            #     raise InvalidAccessRightError.new
	            # end

	            # if @api_user.has_access_to_api_as_domain?
	            #     hostname = params[:hostname].gsub(/www./, '')
	            #     @domain = Domain.where('(name = ? or name = ?) and ip = ?', hostname, "www.#{hostname}", request.remote_ip).first
	            #     if @domain.nil?
	            #         raise DomainNotFoundError.new
	            #     end
	            # end
	        end        

	end
end
