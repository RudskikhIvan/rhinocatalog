class CreateRhinocatalogProducts < ActiveRecord::Migration
	def change
		create_table :rhinocatalog_products do |t|
			t.references :category, index: true
			t.string :name
			t.string :slug, :null => false
			t.text :description

			t.integer :position
			t.boolean :published, default: true

			t.timestamps
		end
		add_index :rhinocatalog_products, :name, :unique => true 
		add_index :rhinocatalog_products, :slug, :unique => true 		
	end
end
