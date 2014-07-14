json.array!(@player_rules) do |player_rule|
  json.extract! player_rule, :id, :rule_id, :user_id, :activated
  json.url player_rule_url(player_rule, format: :json)
end
