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
		before_validation :name_to_slug

		belongs_to :parent, class_name: self.to_s
		has_many :children, class_name: self.to_s, foreign_key: "parent_id", autosave: true

		has_many :products, ->{ order(position: :asc) }, :dependent => :destroy #, :foreign_key => "rhinobook_chapters_id"
		accepts_nested_attributes_for :products, allow_destroy: true, reject_if: :all_blank

		validates :name, presence: true

		acts_as_list scope: :parent_id

		validates_uniqueness_of :name, :slug, :scope => :parent_id

		def self.root
			where parent_id: nil
		end

		def root?
			parent.nil?
		end

		def self.tree(except_id = nil)
			tree = []

			recursive_collect_children(root.includes(:children), tree, 0, except_id)
			tree
		end

		def self.recursive_collect_children(children, tree, level, except_id)
			return if level > 6

			children.reject { |child| child.id == except_id }.each do |child|
				tree.push category: child, level: level

				recursive_collect_children(child.children.includes(:children), tree, level + 1, except_id)
			end
		end	

		def self.tree_for_select_list(except_id = nil)
			tree(except_id).map { |b| [b[:category], b[:level]] }.map do |item, level|
				[("-" * level) + item.name, item.id.to_s]
			end
		end

		def self.tree_for_list
			recursive_collect_children(root.includes(:children), tree, 0, nil)
		end

		def as_json(options = {})
			options[:only] ||= [:id, :name]
			options[:methods] ||= [:children, :products]
			super(options)
		end		

		protected
			def name_to_slug
				if !self.slug.present?
					if self.parent_id.present?
						parent = Category.find(self.parent_id)
						self.slug = parent.slug + "/" + Rhinoart::Utils.to_slug(self.name)
					else
						self.slug = Rhinoart::Utils.to_slug(self.name)
					end
				else
					self.slug = Rhinoart::Utils.to_slug(self.slug)
				end
			end		
	end
end
