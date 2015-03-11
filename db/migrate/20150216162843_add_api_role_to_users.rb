class AddApiRoleToUsers < ActiveRecord::Migration
	def self.up
		add_column :rhinoart_users, :api_role, :string
		add_column :rhinoart_users, :api_token, :string

		add_index :rhinoart_users, :api_role
		add_index :rhinoart_users, :api_token		
	end

	def self.down
		drop_table :rhinoart_users
	end
end
