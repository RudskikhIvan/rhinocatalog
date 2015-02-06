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
	end
end
