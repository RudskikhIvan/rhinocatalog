# == Schema Information
#
# Table name: rhinocatalog_categories
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  name       :string(255)
#  slug       :string(255)      not null
#  position   :integer
#  published  :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#

module Rhinocatalog
	class Category < ActiveRecord::Base
		has_many :products, ->{ order(num: :asc) }, :dependent => :destroy #, :foreign_key => "rhinobook_chapters_id"
		accepts_nested_attributes_for :products, allow_destroy: true, reject_if: :all_blank

		validates :name, presence: true

		acts_as_list scope: :parent_id
	end
end
