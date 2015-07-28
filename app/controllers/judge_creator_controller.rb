class JudgeCreatorController < ApplicationController
  def select_accept
    @smackdown = Smackdown.find(params[:smackdown_id])
  end
  def select_winner
    @smackdown = Smackdown.find(params[:smackdown_id])
    @accepted = (params[:accepted]=='true')
    if !@accepted
      if current_user.id == @smackdown.judge1_id
        @smackdown.judge1_accepted = false
        @smackdown.save
        flash[:notice] = "You rejected to judge a smackdown."
      elsif current_user.id == @smackdown.judge2_id
        @smackdown.judge2_accepted = false
        @smackdown.save
        flash[:notice] = "You rejected to judge a smackdown."
      else
        flash[:notice] = "Error."
      end
      redirect_to "/"
    end
  end
  def select_comment
    @smackdown = Smackdown.find(params[:smackdown_id])
    @accepted = (params[:accepted]=='true')
    @winner = User.find_by_id(params[:winner_id])
  end
end
