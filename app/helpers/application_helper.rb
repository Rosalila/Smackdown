module ApplicationHelper
  def userIsPlayingGame (user_id,game_id)
    upg = UserPlayingGame.where(:user_id=>user_id, :game_id=>game_id)[0]
    if upg == nil
      return false
    end
    return upg.is_playing
  end

  def pendingJudge
    j1 = Smackdown.where(:judge1_id=>current_user.id, :judge1_accepted => nil).count
    j2 = Smackdown.where(:judge2_id=>current_user.id, :judge2_accepted => nil).count
    return j1+j2
  end

  def pendingRespond
    return Smackdown.where(:player2_id=>current_user.id, :player2_accepted=>nil).count
  end

  def playingAtLeastAGame user
    at_least_a_game = false
    Game.all.each do |game|
      rules_ok = true
      game.rule_groups.each do |rule_group|
          at_least_a_rule = false
          rule_group.rules.each do |rule|
            if PlayerRule.where(:user_id=>user.id,:rule_id=>rule.id,:activated=>true)[0]!=nil
              at_least_a_rule = true
            end
          end
          if !at_least_a_rule || !userIsPlayingGame(user.id,game.id)
            rules_ok=false
          end
      end
      if rules_ok
        at_least_a_game = true
      end
    end
    return at_least_a_game
  end

  def getStats
    hash = {'uno' => 1, 'dos' => 2}
  end

end
