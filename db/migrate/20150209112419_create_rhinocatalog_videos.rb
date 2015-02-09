class CreateRhinocatalogVideos < ActiveRecord::Migration
	def change
		create_table :rhinocatalog_videos do |t|
			t.references :videoable, polymorphic: true

			t.string :name
			t.string :file
			t.string :file_content_type
			t.string :resolution_type
			t.integer :position
			t.text :info

			t.timestamps
		end
		add_index :rhinocatalog_videos, :videoable_id
		add_index :rhinocatalog_videos, :videoable_type
		add_index :rhinocatalog_videos, :name
		add_index :rhinocatalog_videos, :file
		add_index :rhinocatalog_videos, :position
	end
end
