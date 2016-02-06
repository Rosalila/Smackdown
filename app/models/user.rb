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
    if auth.provider == "facebook"
      where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
    end
    if auth.provider == "steam"
      if current_user
        current_user.steamid = "testa"
      end
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
    at_least_a_game = false
    Game.all.each do |game|
      rules_ok = true
      game.rule_groups.each do |rule_group|
          at_least_a_rule = false
          rule_group.rules.each do |rule|
            if PlayerRule.where(:user_id=>id,:rule_id=>rule.id,:activated=>true)[0]!=nil
              at_least_a_rule = true
            end
          end
          if !at_least_a_rule || !isPlayingGame(game)
            rules_ok=false
          end
      end
      if rules_ok
        at_least_a_game = true
      end
    end
    return at_least_a_game
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

  def sentASmackdown
    return Smackdown.where(player1_id: id).count>0
  end

  def hasFavourite
    return favorites.count>0
  end

  def receivedASmackdown
    return Smackdown.where(player2_id: id).count>0
  end
  def judgedASmackdown
    return Smackdown.where("judge1_id=? AND (judge1_accepted = ? OR judge1_accepted = ?)",id,true,false).count>0 || Smackdown.where("judge2_id=? AND (judge2_accepted = ? OR judge2_accepted = ?)",id,true,false).count>0
  end
  def belongsToADojo
    return dojos.count>0
  end
  def belongsToACommunity
    return communities.count>0
  end

  def finishedASmackdown
    Smackdown.where(player1_id: id).each do |smackdown|
      if smackdown.isFinished
        return true
      end
    end
    return false
  end
end
