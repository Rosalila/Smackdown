json.array!(@dojos) do |dojo|
  json.extract! dojo, :id, :name, :main_image, :badge_image, :about, :motto, :schedule, :public_address, :latitude, :longitude
  json.url dojo_url(dojo, format: :json)
end
