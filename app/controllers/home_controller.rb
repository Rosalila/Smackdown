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

  def judge2_smackdown
  end

  def judge2_smackdown
  end

end
