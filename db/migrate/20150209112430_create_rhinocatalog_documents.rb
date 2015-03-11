class CreateRhinocatalogDocuments < ActiveRecord::Migration
	def self.up
		create_table :rhinocatalog_documents do |t|
			t.references :documentable, polymorphic: true

			t.string :name
			t.string :file
			t.string :file_content_type
			t.integer :position
			t.text :info

			t.timestamps
		end
		add_index :rhinocatalog_documents, :documentable_id
		add_index :rhinocatalog_documents, :documentable_type
		add_index :rhinocatalog_documents, :name
		add_index :rhinocatalog_documents, :file
		add_index :rhinocatalog_documents, :position
	end

	def self.down
		drop_table :rhinocatalog_documents
	end
end
