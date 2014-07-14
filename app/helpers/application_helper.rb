module ApplicationHelper
  def userIsPlayingGame (user_id,game_id)
    upg = UserPlayingGame.where(:user_id=>user_id, :game_id=>game_id)[0]
    if upg == nil
      return false
    end
    return upg.is_playing
  end
end
