json.array!(@user_in_communities) do |user_in_community|
  json.extract! user_in_community, :id, :user_id, :community_id
  json.url user_in_community_url(user_in_community, format: :json)
end
