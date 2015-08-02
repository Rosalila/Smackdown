class Community < ActiveRecord::Base
  mount_uploader :main_image, FileUploader
  has_many :community_points
  has_many :users, through: :user_in_communities
  has_many :user_in_communities

  def userIsAdmin user
    user_in_community = UserInCommunity.where(user: user, community_id: id)[0]
    if user_in_community == nil
      return false
    end
    return user_in_community.is_admin
  end

  def getSmackdowns
    ids = []
    users.each do |user|
      ids.push(user.id)
    end
    return Smackdown.where(player1_id: ids,player2_id: ids)
  end

  def getStreak
    streak_global_list=[]
    smackdowns = getSmackdowns
    Game.all.each do |game|
      users.each do |user|
        user_smackdown = smackdowns.where("player1_id = ? or player2_id = ?", user.id, user.id).order('created_at DESC')
        streak = 0
        user_smackdown.each do |smackdown|
          if smackdown.game_id == game.id
            if smackdown.isFinished
              if smackdown.playerWins user.id
                streak+=1
              else
                break
              end
            end
          end
        end
        streak_global_list.push([user,streak,game.id])
      end
    end
    return streak_global_list
  end

  def getDifference
    diff_global_list=[]
    smackdowns = getSmackdowns
    Game.all.each do |game|
      users.each do |user|
        user_smackdown = smackdowns.where("player1_id = ? or player2_id = ?", user.id, user.id).order('created_at DESC')
        diff = 0
        smackdown_played = 0
        user_smackdown.each do |smackdown|
          if smackdown.game_id == game.id
            if smackdown.isFinished
              if smackdown.rejected
                if smackdown.player2_id == user.id
                  diff-=1
                else
                  diff+=1
                end
              elsif smackdown.playerWins user.id
                diff+=1
              else
                diff-=1
              end
              smackdown_played+=1
            end
          end
        end
        diff_global_list.push([user,diff,game.id,smackdown_played])
      end
    end
    return diff_global_list
  end
end
