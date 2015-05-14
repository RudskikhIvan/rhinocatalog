require_dependency "rhinocatalog/application_controller"

module Rhinocatalog
	class Api::BaseController < ApplicationController
	    # include ApplicationHelper


	    before_filter :check_if_user_has_access_to_api
	    caches_action :index, :show, expires_in: 2.minutes, :cache_path => Proc.new { |c| "#{c.params}" }

	    class InvalidApiKeyError < StandardError; end
	    class UserNotApprovedError < StandardError; end
	    class InvalidPasswordError < StandardError; end
	    class InvalidEmailError < StandardError; end
	    class InvalidAccessRightError < StandardError; end
	    class ParamTypeError < StandardError; end
	    class NotFoundError < StandardError; end


	    # Prevent CSRF attacks by raising an exception.
	    # For admin panels, you may want to use :exception instead.
	    # protect_from_forgery with: :null_session

	    # skip_before_action :verify_authenticity_token
	    # prepend_before_action :check_if_user_has_access_to_api

	    # we throw CanCan::AccessDenied manually
	    rescue_from CanCan::AccessDenied do |exception|
	      render json: {message: exception.message, error_code: Api::ERROR_ACCESS_DENIED}, status: :unauthorized
	    end

	    rescue_from InvalidApiKeyError do |exception|
	      render json: {message: "Access Denied (invalid API token)", error_code: Api::ERROR_ACCESS_DENIED_INVALID_API_TOKEN}, status: :unauthorized
	    end

	    rescue_from UserNotApprovedError do |exception|
	      render json: {message: "Access Denied (user wasn't approved)", error_code: Api::ERROR_ACCESS_DENIED_USER_WASNT_APPROVED}, status: :unauthorized
	    end

	    rescue_from InvalidPasswordError do |exception|
	      render json: {message: "Access Denied (email/password mismatch)", error_code: Api::ERROR_PASSWORD_MISMATCH}, status: 403
	    end

	    rescue_from InvalidEmailError do |exception|
	      render json: {message: "User with provided email not found", error_code: Api::ERROR_USER_NOT_FOUND}, status: :unauthorized
	    end

	    rescue_from InvalidAccessRightError do |exception|
	      render json: {message: "Access Denied (user has no access right)", error_code: Api::ERROR_ACCESS_DENIED_USER_HAS_NO_ACCESS_RIGHT}, status: 403
	    end

	    rescue_from ParamTypeError do |exception|
	      render json: {message: "Params type error", error_code: Api::ERROR_PARAM_TYPE}, status: 500
	    end

	    rescue_from NotFoundError do |exception|
	      render json: {message: "Content Not Found - 404", error_code: Api::ERROR_CONTENT_NOT_FOUND}, status: 404
	    end

	    private
	        def check_if_user_has_access_to_api
                @api_user = Rhinoart::User.find_by(api_token: params[:api_token])
	            if @api_user.nil?
	                raise InvalidApiKeyError.new
	            end

	            unless @api_user.approved
	                raise UserNotApprovedError.new
	            end

	            if !@api_user.has_access_to_api?
	                raise InvalidAccessRightError.new
	            end
	        end        
	end
end
