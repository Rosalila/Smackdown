json.array!(@communities) do |community|
  json.extract! community, :id, :name, :description, :main_image
  json.url community_url(community, format: :json)
end
