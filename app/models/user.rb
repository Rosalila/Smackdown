class User < ActiveRecord::Base
  has_many :user_playing_games
  has_many :feedbacks

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def smackdownsPlayedByGame game_id
    games_played=0
    Smackdown.where("player1_id = ? or player2_id = ?", id, id).order('created_at DESC').each do |smackdown| 
      if smackdown.isFinished
        if smackdown.game_id == game_id
          games_played+=1
        end
      end
    end
    return games_played
  end
end
