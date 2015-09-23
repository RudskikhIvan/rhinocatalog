json.categories categories.where(published: true) do |category|
	json.(category, :id, :name)
	json.partial! 'children', categories: category.children
	json.partial! 'products', products: category.products
end	