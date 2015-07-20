class ResponseCreatorController < ApplicationController
  def select_accept
    @smackdown = Smackdown.find(params[:smackdown_id])
  end
  def select_judge
    @smackdown = Smackdown.find(params[:smackdown_id])
    @accepted = (params[:accepted]=='true')
    @like_param = params["like_param"]
    if @like_param=="" || @like_param == nil
      @judges=[]
    else
      @judges=User.where("name LIKE ?" , "%#{@like_param}%")
    end
  end
end
