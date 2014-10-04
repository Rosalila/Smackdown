class ShareablesController < ApplicationController
  def versus    
  end

  def smackdown
    @smackdown = Smackdown.find_by_id(params[:id])
  end
end
