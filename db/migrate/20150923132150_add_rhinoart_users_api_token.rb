class AddRhinoartUsersApiToken < ActiveRecord::Migration
	def change
		add_column :rhinoart_users, :api_token, :string
		add_index :rhinoart_users, :api_token
	end
end
