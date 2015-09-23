json.products products.where(published: true) do |product|
	json.(product, :id, :name, :slug, :position, :description, :video)
	json.partial! 'product_documents', documents: product.documents	
	json.partial! 'product_images', images: product.images
end	