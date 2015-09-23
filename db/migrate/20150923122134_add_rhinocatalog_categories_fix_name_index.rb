class AddRhinocatalogCategoriesFixNameIndex < ActiveRecord::Migration
	def change
		remove_index :rhinocatalog_categories, :name
		add_index :rhinocatalog_categories, [:name, :parent_id], :unique => true 
	end
end
