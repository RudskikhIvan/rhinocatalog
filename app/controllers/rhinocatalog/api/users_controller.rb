require_dependency "rhinocatalog/application_controller"

module Rhinocatalog
	class Api::UsersController < Api::BaseController
		skip_before_action :check_if_user_has_access_to_api, only: [:create, :authorize, :request_access]
		# caches_action :authorize, :show, expires_in: 60.seconds, unless_exist: true
		swagger_controller :users, "User Management"

		# POST /api/v1/users.json
		swagger_api :create do
			summary "Creates a new User"
			param :form, :first_name, :string, :required, "First name"
			param :form, :last_name, :string, :required, "Last name"
			param :form, :email, :string, :required, "Email address"
			param_list :form, :api_role, :string, :required, "API Role", [ Rhinoart::User::API_ROLE_USER_MOBILE_APP ]
			response :unauthorized
			response :unprocessable_entity, Api::ERROR_USER_VALIDATION_ERROR
		end		
		def create
			user = Rhinoart::User.new(user_params)
			user.api_role = Rhinoart::User::API_ROLE_USER_MOBILE_APP if !user.api_role.present?
			user.admin_role = nil

			if user.save
				render json: {message: "User Created"}, status: :created, location: [:api, user]
			else
				render json: {message: "Can't create user, see 'errors'", errors: user.errors, error_code: Api::ERROR_USER_VALIDATION_ERROR}, status: :unprocessable_entity
			end
		end

		# Returns API token if user was approved
		#
		# POST /api/v1/users/authorize.json?email=some@email.com&password=1234
		#
		swagger_api :authorize do
			summary "Authorize user. Returns API token if user was approved"
			param :form, :email, :string, :required, "Email"
			param :form, :password, :string, :required, "Password"
			response :unauthorized, Api::ERROR_ACCESS_DENIED
			response :unauthorized, Api::ERROR_USER_NOT_FOUND
			response 403, Api::ERROR_PASSWORD_MISMATCH
			response 403, Api::ERROR_ACCESS_DENIED_USER_HAS_NO_ACCESS_RIGHT
			response :requested_range_not_satisfiable, Api::ERROR_PARAM_TYPE			
		end			
		def authorize
			api_user = Rhinoart::User.find_by(email: user_params[:email], approved: true)

			if api_user.nil?
				raise InvalidEmailError.new
			end

			unless api_user.valid_password? user_params[:password].to_s
				raise InvalidPasswordError.new
			end

			if !api_user.has_access_to_api?
				raise InvalidAccessRightError.new
			end

			sign_in api_user

			render json: { email: api_user.email, api_token: api_user.api_token, name: api_user.name, roles: api_user.api_role, frontend_role: api_user.frontend_role }
		end

		# GET /api/v1/users/<user_id>.json
		#
		# {"id":22,"email":"test@example.com","created_at":"2013-05-29T02:35:29.124Z","updated_at":"2013-05-29T02:35:29.124Z","admin_role":null,"frontend_role":null,"approved":false,"first_name":null,"last_name":null,"phone_no":null,"recommender":null,"interested_in":null,"notes":null,"company_name":null}
		swagger_api :show do
			summary "Show user data"
			param :path, :id, :integer, :required, "User id"
			param :query, :api_token, :string, :required, "Api Token"
			response :unauthorized, Api::ERROR_ACCESS_DENIED
			response :unauthorized, Api::ERROR_ACCESS_DENIED_INVALID_API_TOKEN
			response :unauthorized, Api::ERROR_ACCESS_DENIED_USER_WASNT_APPROVED
			response 403, Api::ERROR_ACCESS_DENIED_USER_HAS_NO_ACCESS_RIGHT
			response :requested_range_not_satisfiable, Api::ERROR_PARAM_TYPE			
		end			
		def show
			if Rhinoart::User.exists?(params[:id])
				user = Rhinoart::User.find(params[:id])
				render json: user
			else
				render json: {message: "User not found", error_code: Api::ERROR_USER_NOT_FOUND}, status: :not_found
			end
		end

		def request_access
			user = Rhinoart::User.find_by(email: params[:request_access][:email])

			if user.nil?
				raise InvalidEmailError.new
			end

			user.notify_request_access(params[:request_access][:site])
			render json: {email: params[:request_access][:email]}   
		end

		private

			def user_params
				params.require(:user).permit(:name, :email, :password, :frontend_role, *Rhinoart::User::SAFE_INFO_ACCESSORS)
			end
	end
end
