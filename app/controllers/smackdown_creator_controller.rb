class SmackdownCreatorController < ApplicationController
  def select_user
    @like_param = params["like_param"]
    @users=User.where("name LIKE ?" , "%#{@like_param}%")
  end

  def select_game
    @user = User.find(params[:user_id])
  end

  def select_judge
    @user = User.find(params[:user_id])
    @game = Game.find(params[:game_id])
    @like_param = params["like_param"]
    @judges=User.where("name LIKE ?" , "%#{@like_param}%")
  end

  def select_rules
    @user = User.find(params[:user_id])
    @game = Game.find(params[:game_id])
    @judge1_id = params[:judge1_id]
  end
end
