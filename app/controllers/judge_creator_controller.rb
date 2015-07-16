class JudgeCreatorController < ApplicationController
  def select_accept
    @smackdown = Smackdown.find(params[:smackdown_id])
  end
  def select_winner
    @smackdown = Smackdown.find(params[:smackdown_id])
    @accepted = (params[:accepted]=='true')
  end
  def select_comment
    @smackdown = Smackdown.find(params[:smackdown_id])
    @accepted = (params[:accepted]=='true')
    @winner = User.find_by_id(params[:winner_id])
  end
end
