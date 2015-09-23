json.documents documents do |document|
	json.(document, :id, :name, :position, :file_size)
	json.url document.file.url
end	