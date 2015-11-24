class ChangeRhinocatalogProductsNameIndex < ActiveRecord::Migration
  def change
    remove_index :rhinocatalog_products, :name
    remove_index :rhinocatalog_products, :slug
    add_index :rhinocatalog_products, [:name, :category_id], :unique => true
    add_index :rhinocatalog_products, [:slug, :category_id], :unique => true
  end
end
