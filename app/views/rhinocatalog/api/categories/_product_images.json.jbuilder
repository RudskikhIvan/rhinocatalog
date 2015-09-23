json.images images do |image|
	json.(image, :id, :position, :file_size)
	json.file( url: image.file.url, large: {url: image.file.large.url}, thumb: {url: image.file.thumb.url})
end	
