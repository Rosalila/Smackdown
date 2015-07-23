class HomeController < ApplicationController
  def index
    redirect_to 'http://smackdown.club/home/index' if url_for(:only_path => false) == 'http://www.smackdown.club/home/index'
  end

  def visit
  end

  def send_smackdown
    #<% params["rule"].each do |rule| %>
    #  <p><%= Rule.find_by_id(rule[1]).name %></p>
    #<% end %>
    judge1_id = params["judge_id"]
    player2_id = params["opponent_id"]

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
      format.html { redirect_to "/home/wating_opponent", notice: '¡Has enviado un Smackdown!' }
    end
  end

  def respond_smackdown
    judge2_id = params["judge_id"]
    player2_accepted = params["player2_accepted"]
    smackdown_id = params["smackdown_id"]

    smackdown = Smackdown.find_by_id(smackdown_id)
    smackdown.judge2_id = judge2_id
    smackdown.player2_accepted = player2_accepted
    smackdown.save

    respond_to do |format|
      format.html { redirect_to "/home/wating_judges", notice: '¡Has respondido un Smackdown!' }
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
      smackdown.judge1_accepted = judge_accepted
      smackdown.judge1_winner_id = winner_id
      smackdown.judge1_comment = judge_comment
      correct = true
    end
    if smackdown.judge2_id == current_user.id
      smackdown.judge2_accepted = judge_accepted
      smackdown.judge2_winner_id = winner_id
      smackdown.judge2_comment = judge_comment
      correct = true
    end

    if correct && smackdown.save
      respond_to do |format|
        format.html { redirect_to "/home/history_judged_smackdowns", notice: '¡Has juzgado un Smackdown!' }
      end
    else
      respond_to do |format|
        format.html { redirect_to "/home/history_judged_smackdowns", notice: '¡Ocurrio un error!' }
      end
    end
  end

  def judge1_smackdown
    smackdown_id = params["smackdown_id"]
    judge1_accepted = params["judge1_accepted"]
    winner_id = params["winner_id"]
    judge1_comment = params["judge1_comment"]

    smackdown = Smackdown.find_by_id(smackdown_id)
    smackdown.judge1_accepted = judge1_accepted
    smackdown.judge1_winner_id = winner_id
    if smackdown.judge1_id == smackdown.judge2_id
      smackdown.judge2_winner_id = winner_id
    end
    smackdown.judge1_comment = judge1_comment
    smackdown.save

    respond_to do |format|
      format.html { redirect_to "/home/history_judged_smackdowns", notice: '¡Has juzgado un Smackdown!' }
    end
  end

  def judge2_smackdown
    smackdown_id = params["smackdown_id"]
    judge2_accepted = params["judge2_accepted"]
    winner_id = params["winner_id"]
    judge2_comment = params["judge2_comment"]

    smackdown = Smackdown.find_by_id(smackdown_id)
    smackdown.judge2_accepted = judge2_accepted
    smackdown.judge2_winner_id = winner_id
    smackdown.judge2_comment = judge2_comment  
    smackdown.save

    respond_to do |format|
      format.html { redirect_to "/home/history_judged_smackdowns", notice: '¡Has juzgado un Smackdown!' }
    end
  end

  def explore
    @like_param = params["like_param"]
    @favorite_id = params["favorite_id"]

    if @favorite_id != "" && @favorite_id != nil
      current_user.toggleFavorite @favorite_id
    end

    if @like_param == "" || @like_param == nil
      if current_user
        @users = current_user.getFavorites
      else
        @users = User.all.shuffle[0..1]
      end
    else
      if current_user
        @users=User.where("name LIKE ?" , "%#{@like_param}%").where.not(user_id: current_user.id)
      else
        @users=User.where("name LIKE ?" , "%#{@like_param}%")
      end
    end
  end

  def history_sent_smackdowns
    @smackdowns = Smackdown.where(:player1_id=>current_user.id)
  end

  def history_received_smackdowns
    @smackdowns = Smackdown.where(:player2_id=>current_user.id, :player2_accepted=>[true,false])
  end

  def history_judged_smackdowns
    @judge1_smackdowns = Smackdown.where(:judge1_id=>current_user.id, :judge1_accepted => [true,false])
    @judge2_smackdowns = []
    Smackdown.where(:judge2_id=>current_user.id, :judge2_accepted => [true,false]).each do |smackdown|
      next if smackdown.judge1_id==smackdown.judge2_id
      @judge2_smackdowns.push(smackdown)
    end
  end

  def profile
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
end
