# == Schema Information
#
# Table name: rhinocatalog_documents
#
#  id                :integer          not null, primary key
#  documentable_id   :integer
#  documentable_type :string(255)
#  name              :string(255)
#  file              :string(255)
#  file_content_type :string(255)
#  position          :integer
#  info              :text
#  created_at        :datetime
#  updated_at        :datetime
#

module Rhinocatalog
	class Document < ActiveRecord::Base
		belongs_to :documentable, polymorphic: true

		# SAFE_INFO_ACCESSORS = [ :alt, :title ]
		# store :info, accessors: SAFE_INFO_ACCESSORS, coder: JSON

		validates :file, presence: true	

		mount_uploader :file, DocumentUploader
	    acts_as_list scope: [:documentable_id, :documentable_type]

	    def as_json(options = {})
	        options[:only] ||= [:id, :name, :file]
	        options[:methods] ||= [:file_size]
	        super(options)
	    end

	    def file_size
	        file.size
	    end		
	end
end
