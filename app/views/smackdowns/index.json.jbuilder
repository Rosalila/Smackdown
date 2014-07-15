json.array!(@smackdowns) do |smackdown|
  json.extract! smackdown, :id, :player1_id, :player2_id, :judge1_id, :judge2_id, :judge1_winner_id, :judge2_winner_id, :player2_accepted, :judge1_accepted, :judge2_accepted, :judge1_comment, :judge2_comment
  json.url smackdown_url(smackdown, format: :json)
end
