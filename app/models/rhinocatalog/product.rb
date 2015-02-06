# == Schema Information
#
# Table name: rhinocatalog_products
#
#  id          :integer          not null, primary key
#  category_id :integer
#  name        :string(255)
#  slug        :string(255)      not null
#  description :text
#  position    :integer
#  published   :boolean          default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime
#

module Rhinocatalog
	class Product < ActiveRecord::Base
		before_validation :name_to_slug

		belongs_to :categiry, class_name: self.to_s

		has_many :images, ->{ order(position: :asc) }, as: :imageable, :dependent => :destroy
		accepts_nested_attributes_for :images, allow_destroy: true

		acts_as_list scope: :category_id

		validates_uniqueness_of :name, :slug, :scope => :category_id

		def as_json(options = {})
			options[:only] ||= [:id, :name, :description, :position]
			options[:methods] ||= [:images]

			super(options)
			# super.tap { |hash| hash["content"] = hash.delete "content_clear" }
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
