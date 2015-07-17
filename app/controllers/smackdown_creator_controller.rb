class SmackdownCreatorController < ApplicationController
  def select_user
    @like_param = params["like_param"]
    @users=User.where("name LIKE ?" , "%#{@like_param}%")
  end

  def select_game
    @user = User.find(params[:user_id])
  end

  def select_rules
    @user = User.find(params[:user_id])
    @game = Game.find(params[:game_id])
  end
end
