class AddShowOnFrontendToProducts < ActiveRecord::Migration
	def change
		add_column :rhinocatalog_products, :show_on_frontend, :boolean, default: true
		add_index :rhinocatalog_products, :show_on_frontend
	end
end
