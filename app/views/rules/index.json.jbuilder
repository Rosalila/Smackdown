json.array!(@rules) do |rule|
  json.extract! rule, :id, :rule_group_id, :name
  json.url rule_url(rule, format: :json)
end
