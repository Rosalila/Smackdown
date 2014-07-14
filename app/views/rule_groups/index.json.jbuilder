json.array!(@rule_groups) do |rule_group|
  json.extract! rule_group, :id, :game_id, :name
  json.url rule_group_url(rule_group, format: :json)
end
