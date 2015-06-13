class Smackdown < ActiveRecord::Base
  has_many :smackdown_rules
  def sa
    if judge1_id == judge2_id
      return true
    else 
      return false
    end
  end
  def rejected
    return player2_accepted == false
  end

  def player1Wins
    return !rejected && judge1_winner_id == player1_id && judge2_winner_id == player1_id
  end

  def player2Wins
    return !rejected && !player1Wins && judge1_winner_id == player2_id && judge2_winner_id == player2_id
  end

  def playerWins player_id
    if (player1Wins && player_id == player1_id) || (player2Wins && player_id == player2_id)
      return true
    end
    return false
  end

  def isFinished
    return rejected || player1Wins || player2Wins
  end

end
