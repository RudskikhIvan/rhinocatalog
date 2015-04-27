# == Schema Information
#
# Table name: rhinocatalog_products
#
#  id               :integer          not null, primary key
#  category_id      :integer
#  name             :string(255)
#  slug             :string(255)      not null
#  description      :text(65535)
#  position         :integer
#  published        :boolean          default(TRUE)
#  created_at       :datetime
#  updated_at       :datetime
#  show_on_frontend :boolean          default(TRUE)
#

module Rhinocatalog
	class Product < ActiveRecord::Base
		before_validation :name_to_slug

		belongs_to :category, class_name: self.to_s

		has_many :images, ->{ order(position: :asc) }, as: :imageable, :dependent => :destroy
		accepts_nested_attributes_for :images, allow_destroy: true

		has_many :videos, as: :videoable, autosave: true, :dependent => :destroy
		# has_many :videos, ->{ order(position: :asc) }, as: :videoable, :dependent => :destroy
		# accepts_nested_attributes_for :videos, allow_destroy: true#, reject_if: proc { |s| s['file'].blank? }

		has_many :documents, ->{ order(position: :asc) }, as: :documentable, :dependent => :destroy
		accepts_nested_attributes_for :documents, allow_destroy: true, reject_if: :all_blank

		acts_as_list scope: :category_id

		validates :name, :slug, presence: true
		validates_uniqueness_of :name, :slug, :scope => :category_id

		has_paper_trail

		def hd_video
			videos.find_by(resolution_type: Video::VIDEO_TYPE_HD)
		end
		def hd_video=(new_video)
			videos.where(resolution_type: Video::VIDEO_TYPE_HD).destroy_all			
			videos(1) << Video.new(resolution_type: Video::VIDEO_TYPE_HD, file: new_video) if new_video.class.name == 'ActionDispatch::Http::UploadedFile'
		end

		def sd_video
			videos.find_by(resolution_type: Video::VIDEO_TYPE_SD)
		end
		def sd_video=(new_video)
			videos.where(resolution_type: Video::VIDEO_TYPE_SD).destroy_all
			videos(1) << Video.new(resolution_type: Video::VIDEO_TYPE_SD, file: new_video) if new_video.class.name == 'ActionDispatch::Http::UploadedFile'
		end

		def ipad_video
			videos.find_by(resolution_type: Video::VIDEO_TYPE_43)
		end
		def ipad_video=(new_video)
			videos.where(resolution_type: Video::VIDEO_TYPE_43).destroy_all
			videos(1) << Video.new(resolution_type: Video::VIDEO_TYPE_43, file: new_video) if new_video.class.name == 'ActionDispatch::Http::UploadedFile'
		end

		def as_json(options = {})
			options[:only] ||= [:id, :category_id, :name, :position]
			options[:methods] ||= [:images, :video, :documents, :clean_description]

			super(options)
			super.tap { |hash| 
				hash["description"] = hash.delete "clean_description" 
				# hash["images"] = hash.delete "first_image"
			}
		end

		def video
			{ hd: hd_video, sd: sd_video, ipad: ipad_video } 
		end	

		# def first_image
		# 	self.images.first if self.images.any?
		# end

		def clean_description
			require 'sanitize'
			Sanitize.fragment self.description
		end

		protected
			def name_to_slug
				if !self.slug.present?
					self.slug = Rhinoart::Utils.to_slug(self.name)
				else
					self.slug = Rhinoart::Utils.to_slug(self.slug)
				end
			end	
	end
end
