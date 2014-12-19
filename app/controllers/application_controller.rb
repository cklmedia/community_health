class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate
  helper_method :logined?, :current_user

  def current_user
    @current_user ||= login_from_session unless defined?(@current_user)
    @current_user
  end

  def sign_in(user)
    session[:user_id] = user.id
    session[:class] = user.class.to_s
    @current_user = user
  end

  def logined?
    !current_user.nil?
  end

  def login_from_session
    if session[:user_id].present?
      begin
        user = Doctor.find session[:user_id] if session[:class] == "Doctor"
        user = Member.find session[:user_id] if session[:class] == "Member"
        user
      rescue
        session[:user_id] = nil
        session[:class] = nil
      end
    end
  end
  def authenticate
    if ["members","doctors"].include?(params["controller"])
      return ["create"].include?(params["action"])
    end
    return if params[:controller] == "sessions"
    unless logined?
     redirect_to new_session_path
     return
    end
  end
end
