json.array!(@smackdown_rules) do |smackdown_rule|
  json.extract! smackdown_rule, :id, :smackdown_id, :rule_id
  json.url smackdown_rule_url(smackdown_rule, format: :json)
end
