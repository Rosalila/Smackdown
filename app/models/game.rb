class Game < ActiveRecord::Base
  has_many :rule_groups
  has_many :user_playing_game
end
