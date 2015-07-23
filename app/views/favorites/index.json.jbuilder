json.array!(@favorites) do |favorite|
  json.extract! favorite, :id, :user_id, :favorited_id
  json.url favorite_url(favorite, format: :json)
end
