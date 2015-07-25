json.array!(@user_in_dojos) do |user_in_dojo|
  json.extract! user_in_dojo, :id, :user_id, :dojo_id, :is_admin
  json.url user_in_dojo_url(user_in_dojo, format: :json)
end
