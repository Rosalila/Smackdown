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
    j2 = Smackdown.where(:judge2_id=>current_user.id, :judge2_accepted => nil).where.not(:judge1_id=>current_user.id).count
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

  def getStats user1, user2
    user1_rechazadas = 0
    user2_rechazadas = 0
    user1_ganadas = 0
    user2_ganadas = 0
    conflictos = 0
    pendientes = 0
    errores = 0
    totales = 0

    Smackdown.where(:player1_id=>user1.id, :player2_id=>user2.id).each do |smackdown|
      if smackdown.player2_accepted == false
        user2_rechazadas+=1
      elsif smackdown.judge1_winner_id == user1.id && smackdown.judge2_winner_id == user1.id
        user1_ganadas+=1
      elsif smackdown.judge1_winner_id == user2.id && smackdown.judge2_winner_id == user2.id
        user2_ganadas+=1
      elsif smackdown.judge1_winner_id == nil || smackdown.judge2_winner_id == nil
        pendientes+=1
      elsif smackdown.judge1_winner_id != smackdown.judge2_winner_id
        conflictos+=1
      else
        errores+=1
      end
    end

    Smackdown.where(:player2_id=>user1.id, :player1_id=>user2.id).each do |smackdown|
      if smackdown.player2_accepted == false
        user1_rechazadas+=1
      elsif smackdown.judge1_winner_id == user1.id && smackdown.judge2_winner_id == user1.id
        user1_ganadas+=1
      elsif smackdown.judge1_winner_id == user2.id && smackdown.judge2_winner_id == user2.id
        user2_ganadas+=1
      elsif smackdown.judge1_winner_id == nil || smackdown.judge2_winner_id == nil
        pendientes+=1
      elsif smackdown.judge1_winner_id != smackdown.judge2_winner_id
        conflictos+=1
      else
        errores+=1
      end
    end

    return {'user1_rechazadas' => user1_rechazadas, 'user2_rechazadas' => user2_rechazadas, 'user1_ganadas' => user1_ganadas, 'user2_ganadas' => user2_ganadas, 'conflictos'=>conflictos, 'pendientes'=>pendientes, 'errores' => errores, 'totales'=>totales}
  end

end
