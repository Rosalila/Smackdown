class HomeController < ApplicationController
  def index
    redirect_to 'http://smackdown.club/home/explore' if url_for(:only_path => false) == 'http://www.smackdown.club/home/explore'
  end

  def visit
  end

  def send_smackdown
    judge1_id = params["judge_id"]
    player2_id = params["opponent_id"]
    game = Rule.find_by_id(params["rule"].first.second).rule_group.game
    player2 = User.find_by_id(player2_id)

    if !current_user
      redirect_to "/"
      return
    end
    if !User.find_by_id(player2_id).isPlayingGame(game)
      redirect_to "/"
      return
    end
    if current_user.id == judge1_id || current_user.id == player2_id
      redirect_to "/"
      return
    end
    params["rule"].each do |rule|
      rule_id = rule[1]
      if !player2.hasRule rule_id.to_i
        redirect_to "/"
        return
      end
    end

    smackdown = Smackdown.new
    smackdown.judge1_id = judge1_id
    smackdown.player1_id = current_user.id
    smackdown.player2_id = player2_id

    smackdown.save

    params["rule"].each do |rule|
      rule_id = rule[1]
      smackdown_rule = SmackdownRule.new
      smackdown_rule.smackdown_id = smackdown.id
      smackdown_rule.rule_id = rule_id
      smackdown_rule.save
    end
    respond_to do |format|
      format.html { redirect_to "/shareables/smackdown/"+smackdown.id.to_s+"/0", notice: 'You have sent a Smackdown!' }
    end
  end

  def respond_smackdown
    judge2_id = params["judge_id"]
    player2_accepted = params["player2_accepted"]
    smackdown_id = params["smackdown_id"]
    smackdown = Smackdown.find_by_id(smackdown_id)

    if current_user.id == judge2_id || current_user.id != smackdown.player2_id
      redirect_to "/"
      return
    end

    smackdown.judge2_id = judge2_id
    smackdown.player2_accepted = player2_accepted
    smackdown.save

    respond_to do |format|
      format.html { redirect_to "/shareables/smackdown/"+smackdown.id.to_s+"/0", notice: 'You answered a Smackdown!' }
    end

  end

  def judge_smackdown
    smackdown_id = params["smackdown_id"].to_i
    judge_accepted = params["judge_accepted"]=="true"
    winner_id = params["winner_id"].to_i
    judge_comment = params["judge_comment"]

    smackdown = Smackdown.find_by_id(smackdown_id)
    correct = false
    if smackdown.judge1_id == current_user.id
      if smackdown.player1_id == winner_id || smackdown.player2_id == winner_id
        smackdown.judge1_accepted = judge_accepted
        smackdown.judge1_winner_id = winner_id
        smackdown.judge1_comment = judge_comment
        correct = true
      end
    end
    if smackdown.judge2_id == current_user.id
      if smackdown.player1_id == winner_id || smackdown.player2_id == winner_id
        smackdown.judge2_accepted = judge_accepted
        smackdown.judge2_winner_id = winner_id
        smackdown.judge2_comment = judge_comment
        correct = true
      end
    end

    if correct && smackdown.save
      respond_to do |format|
        format.html { redirect_to "/shareables/smackdown/"+smackdown.id.to_s+"/0", notice: 'You have judged Smackdown!' }
      end
    else
      respond_to do |format|
        format.html { redirect_to "/shareables/smackdown/"+smackdown.id.to_s+"/0", notice: 'Error!' }
      end
    end
  end

  def explore
    @like_param = params["like_param"]
    @favorite_id = params["favorite_id"]
    @locale = params["locale"]

    if @locale == "es"
      I18n.locale = :es
    elsif @locale == "en"
      I18n.locale = :en
    end

    if @favorite_id != "" && @favorite_id != nil
      current_user.toggleFavorite @favorite_id
    end

    if @like_param == "" || @like_param == nil
      if current_user
        @users = current_user.getFavorites
        if @users.count == 0
          if current_user
            @users = []
          else
            @users = User.all.shuffle[0..5]
          end
        end
      else
        if current_user
          @users = []
        else
          @users = User.all.shuffle[0..5]
        end
      end
    else
      if current_user
        @users=User.where("name LIKE ?" , "%#{@like_param}%").where.not(id: current_user.id)
      else
        @users=User.where("name LIKE ?" , "%#{@like_param}%")
      end
    end
  end

  def history_sent_smackdowns
    @smackdowns = Smackdown.where(:player1_id=>current_user.id).paginate(:page => params[:page], :per_page => 5)
  end

  def history_received_smackdowns
    @smackdowns = Smackdown.where(:player2_id=>current_user.id, :player2_accepted=>[true,false]).paginate(:page => params[:page], :per_page => 5)
  end

  def history_judged_smackdowns
    @judge_smackdowns = Smackdown.where("(judge1_id = ? AND (judge1_accepted = ? OR judge1_accepted = ?)) OR (judge1_id = ? AND (judge1_accepted = ? OR judge1_accepted = ?))", current_user.id,true,false,current_user.id,true,false).paginate(:page => params[:page], :per_page => 5)
  end

  def profile

#   if session[:steamid]!=nil
#      u = User.find_by_id(current_user.id)
#      u.steamid=session[:steamid]
#      u.save
#    end

   @test=$x

   if session[:steamid]!=nil
      u = User.find_by_id(current_user.id)
      u.steamid=@test
      u.save
    end

   if current_user.steamid
     require 'net/http'
     source = 'http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=63B42B959BC86C52FCA00AD37AFCC81C&steamid='
     source+= current_user.steamid 
     source+='&format=json&&include_appinfo=1'
     resp = Net::HTTP.get_response(URI.parse(source))
     data = resp.body
     @games_played = JSON.parse(data)
   end
  end

  def pending_respond_smackdowns
    @smackdowns = Smackdown.where(:player2_id=>current_user.id, :player2_accepted=>nil)
  end

  def pending_judge_smackdowns
    @judge1_smackdowns = Smackdown.where(:judge1_id=>current_user.id, :judge1_accepted => nil)
    @judge2_smackdowns = []
    Smackdown.where(:judge2_id=>current_user.id, :judge2_accepted => nil).each do |smackdown|
      next if smackdown.judge1_id==smackdown.judge2_id
      @judge2_smackdowns.push(smackdown)
    end
  end

  def wating_opponent
    @smackdowns = Smackdown.where(:player1_id=>current_user.id).where(:player2_accepted=>nil)
  end

  def wating_judges
    smackdown_table = Smackdown.arel_table
    user_smackdowns=Smackdown.where(smackdown_table[:player1_id].eq(current_user.id).or(smackdown_table[:player2_id].eq(current_user.id)))
    different_judges = user_smackdowns.where("smackdowns.judge1_id != smackdowns.judge2_id").where(smackdown_table[:judge1_accepted].eq(nil).or(smackdown_table[:judge2_accepted].eq(nil)))
    same_judges = user_smackdowns.where("smackdowns.judge1_id == smackdowns.judge2_id").where(judge1_accepted: nil).where(judge2_accepted: nil)
    @smackdowns = different_judges + same_judges
  end

  def ajax_test
    render :js => "alert('Bola')"
  end

  def respond_smackdown_page
    @smackdown = Smackdown.find_by_id(params[:smackdown_id].to_i)
  end

  def judge_smackdown_page
    @smackdown = Smackdown.find_by_id(params[:smackdown_id].to_i)
  end

  def waiting_opponent_page
    @smackdown = Smackdown.find_by_id(params[:smackdown_id].to_i)
  end

  def waiting_judge_page
    @smackdown = Smackdown.find_by_id(params[:smackdown_id].to_i)
  end

  def set_rules
    player_rules=params["player_rules"]
    player_rules.each do |player_rule_params|
      player_rule = PlayerRule.find_by_id(player_rule_params.first)
      if player_rule_params.second == "on" && player_rule.user_id == current_user.id
        player_rule.activated = true
      else
        player_rule.activated = false
      end
      player_rule.save
    end
    redirect_to "/home/profile"
  end
end
