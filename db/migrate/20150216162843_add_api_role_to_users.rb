class AddApiRoleToUsers < ActiveRecord::Migration
	def change
		add_column :rhinoart_users, :api_role, :string
		add_column :rhinoart_users, :api_token, :string

		add_index :rhinoart_users, :api_role
		add_index :rhinoart_users, :api_token		
	end
end
