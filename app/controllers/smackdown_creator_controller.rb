class SmackdownCreatorController < ApplicationController
  def select_user
    @like_param = params["like_param"]
    if @like_param=="" || @like_param == nil
      @users=[]
    else
      @users=User.where("name LIKE ?" , "%#{@like_param}%")
    end
  end

  def select_game
    @user = User.find(params[:user_id])
  end

  def select_judge
    @user = User.find(params[:user_id])
    @game = Game.find(params[:game_id])
    @like_param = params["like_param"]
    if @like_param=="" || @like_param == nil
      @judges=[]
    else
      @judges=User.where("name LIKE ?" , "%#{@like_param}%")
    end
  end

  def select_rules
    @user = User.find(params[:user_id])
    @game = Game.find(params[:game_id])
    @judge = User.find(params[:judge_id])
  end
end
