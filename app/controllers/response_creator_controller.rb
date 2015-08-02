class ResponseCreatorController < ApplicationController
  def select_accept
    @smackdown = Smackdown.find(params[:smackdown_id])
  end
  def select_judge
    @smackdown = Smackdown.find(params[:smackdown_id])
    @accepted = (params[:accepted]=='true')
    @like_param = params["like_param"]
    if !@accepted
      if current_user.id == @smackdown.player2_id
        @smackdown.player2_accepted = false
        @smackdown.save
        flash[:notice] = "You rejected a smackdown."
      else
        flash[:notice] = "Error."
      end
      redirect_to "/"
      return
    end
    if @like_param=="" || @like_param == nil
      @judges=[]
    else
      @judges=User.where("name LIKE ?" , "%#{@like_param}%")
    end
  end
end
