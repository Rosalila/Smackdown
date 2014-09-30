class SmackdownCreatorController < ApplicationController
  def select_user
  end

  def select_game
    @user = User.find(params[:user_id])
  end

  def select_rules
    @user = User.find(params[:user_id])
    @game = Game.find(params[:game_id])
  end
end
