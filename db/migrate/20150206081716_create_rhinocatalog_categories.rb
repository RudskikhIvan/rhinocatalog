class CreateRhinocatalogCategories < ActiveRecord::Migration
	def self.up
		create_table :rhinocatalog_categories do |t|
			t.references :parent, index: true
			t.string :name
			t.string :slug, :null => false

			t.integer :position
			t.boolean :published, default: true

			t.timestamps
		end
		add_index :rhinocatalog_categories, :name, :unique => true 
		add_index :rhinocatalog_categories, :slug, :unique => true 
	end

	def self.down
		drop_table :rhinocatalog_categories
	end
end
