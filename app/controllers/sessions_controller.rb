class SessionsController < ApplicationController
  def create
    provider_info = User.from_omniauth(env["omniauth.auth"])
    if provider_info[0] == "steam"
      session["nanaex"]=provider_info[1]
      $x=provider_info[1]

      u = User.find_by_id(self.current_user.id)
      u.steamid="xxxxxx"
      u.save

      redirect_to "/home/profile"
      #redirect_to("/home/profile?chanchada="+provider_info[1], flash: {:notice => "Sorry there was an error"})
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
