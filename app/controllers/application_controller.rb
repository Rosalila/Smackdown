class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def current_user
    if Rails.env.production?
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    else
      User.first
    end
  end
  helper_method :current_user
end
