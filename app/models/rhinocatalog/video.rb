# == Schema Information
#
# Table name: rhinocatalog_videos
#
#  id                :integer          not null, primary key
#  videoable_id      :integer
#  videoable_type    :string(255)
#  name              :string(255)
#  file              :string(255)
#  file_content_type :string(255)
#  resolution_type   :string(255)
#  position          :integer
#  info              :text(65535)
#  created_at        :datetime
#  updated_at        :datetime
#

module Rhinocatalog
	class Video < ActiveRecord::Base
		belongs_to :videoable, polymorphic: true

		# SAFE_INFO_ACCESSORS = [ :alt, :title ]
		# store :info, accessors: SAFE_INFO_ACCESSORS, coder: JSON

		validates :file, presence: true	

		mount_uploader :file, VideoUploader
	    # acts_as_list scope: [:videoable_id, :videoable_type]

		VIDEO_TYPE_HD = "video hd"
		VIDEO_TYPE_SD = "video sd"
		VIDEO_TYPE_43 = "video 4:3"

		VIDEO_TYPES = local_constants.select { |const| const.to_s.starts_with? "VIDEO_TYPE_" }

		has_paper_trail

	    def as_json(options = {})
	        options[:only] ||= [:id, :file]
	        options[:methods] ||= [:file_size]
	        super(options)
	    end

	    def file_size
	        file.size
	    end	

	    # def video_hd
	    # 	self.where(resolution_type: VIDEO_TYPE_HD)
	    # end	
	end
end
