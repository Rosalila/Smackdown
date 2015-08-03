class User < ActiveRecord::Base
  has_many :user_playing_games
  has_many :feedbacks
  has_many :favorites
  has_many :dojos, through: :user_in_dojos
  has_many :user_in_dojos
  has_many :dojo_invitations
  has_many :communities, through: :user_in_communities
  has_many :user_in_communities
  has_many :rules, through: :player_rules
  has_many :player_rules

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

  def hasRule rule_id
    rules.each do |rule|
      if rule.id == rule_id
        return true
      end
    end
    return false
  end

  def isPlayingGame game
    user_playing_game = UserPlayingGame.where(user_id: id,game: game)[0]
    if user_playing_game==nil
      return false
    end
    return user_playing_game.is_playing
  end

  def isPlayingAGame
    user_playing_games.each do |upg|
      if upg.is_playing
        return true
      end
    end
    return false
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

  def getFavorites
    return_value=[]
    favorites.each do |favorite|
      u = User.find_by_id(favorite.favorited_id)
      if u!= nil
        return_value.push(u)
      end
    end
    return return_value
  end

  def toggleFavorite param_favorite_id
    f = Favorite.where(user_id: id,favorited_id: param_favorite_id)[0]
    if f==nil
      Favorite.create(user_id: id,favorited_id: param_favorite_id)[0]
    else
      f.destroy
      f.save
    end
  end
end
