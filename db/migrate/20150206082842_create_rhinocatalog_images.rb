class CreateRhinocatalogImages < ActiveRecord::Migration
	def change
		create_table :rhinocatalog_images do |t|
			t.references :imageable, polymorphic: true

			t.string :name
			t.string :file
			t.string :file_content_type
			t.integer :position
			t.text :info

			t.timestamps
		end
		add_index :rhinocatalog_images, :imageable_id
		add_index :rhinocatalog_images, :imageable_type
		add_index :rhinocatalog_images, :name
		add_index :rhinocatalog_images, :file
		add_index :rhinocatalog_images, :position
	end
end
