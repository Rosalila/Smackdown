json.array!(@user_playing_games) do |user_playing_game|
  json.extract! user_playing_game, :id, :user_id, :game_id, :is_playing
  json.url user_playing_game_url(user_playing_game, format: :json)
end
