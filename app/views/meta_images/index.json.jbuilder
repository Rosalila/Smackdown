json.array!(@meta_images) do |meta_image|
  json.extract! meta_image, :id, :path
  json.url meta_image_url(meta_image, format: :json)
end
