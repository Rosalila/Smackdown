class HomeController < ApplicationController
  def index
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

  end

  def respond_smackdown
    judge2_id = params["judge_id"]
    player2_accepted = params["player2_accepted"]
    smackdown_id = params["smackdown_id"]

    smackdown = Smackdown.find_by_id(smackdown_id)
    smackdown.judge2_id = judge2_id
    smackdown.player2_accepted = player2_accepted
    smackdown.save
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
  end

  def users
  end

  def sent_smackdowns
  end

  def received_smackdowns
  end

  def profile
  end

  def judged_smackdowns
  end

  def respond_smackdowns_list
  end

  def judge_smackdowns_list
    @judge1_smackdowns = Smackdown.where(:judge1_id=>current_user.id)
  end

  def watch
  end

  def wating_opponent
  end

  def wating_judges
  end
end
