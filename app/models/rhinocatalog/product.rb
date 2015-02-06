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
		belongs_to :categiry#, :foreign_key => "rhinobook_chapters_id"

		has_many :images, ->{ order(position: :asc) }, as: :imageable, :dependent => :destroy
		accepts_nested_attributes_for :images, allow_destroy: true

	end
end
