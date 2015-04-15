# desc "Explaining what the task does"
# task :rhinocatalog do
#   # Task goes here
# end


namespace :rhinocatalog do
	desc "Set user api roles"
	task set_user_api_roles: :environment do
		Rhinoart::User.all.each do |user|
			Rhinoart::User::API_ROLES.each do |role|
				begin
					user.add_role role
				rescue					
				end				
			end
		end
	end

	desc "Unset user api roles"
	task unset_user_api_roles: :environment do
		Rhinoart::User.all.each do |user|
			Rhinoart::User::API_ROLES.each do |role|
				begin
					user.remove_role role
				rescue					
				end				
			end
		end
	end

	desc "Reset user api token"
	task reset_user_api_token: :environment do
		Rhinoart::User.all.each do |user|
			user.api_token = SecureRandom.hex(17)
			user.save
		end
	end

end
