json.array!(@community_points) do |community_point|
  json.extract! community_point, :id, :community_id, :latitude, :longitude
  json.url community_point_url(community_point, format: :json)
end
