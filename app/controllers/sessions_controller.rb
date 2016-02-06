class SessionsController < ApplicationController
  def create
    provider_info = User.from_omniauth(env["omniauth.auth"])
    if provider_info[0] == "steam"
      u = User.find_by_id(current_user.id)
      u.steamid=provider_info[1]
      u.save
      redirect_to "/home/profile"
    else
      session[:user_id] = provider_info[1].id
      if !provider_info[1].isPlayingAGame
        redirect_to "/home/profile"
      else
        redirect_to root_url
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
