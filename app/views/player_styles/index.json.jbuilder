json.array!(@player_styles) do |player_style|
  json.extract! player_style, :id, :name, :image, :description, :long_description_link
  json.url player_style_url(player_style, format: :json)
end
