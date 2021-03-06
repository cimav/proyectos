class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  protect_from_forgery unless: -> { request.format.json? }

  def authenticated?
    if session[:user_auth].blank?
      user = User.where(:email => session[:user_email], :status => User::STATUS_ACTIVE).first

      session[:user_auth] = user && user.email == session[:user_email]
      if session[:user_auth]
        session[:user_id] = user.id
      end
    else
      session[:user_auth]
    end
  end
  helper_method :authenticated?
  helper_method :current_user

  def auth_required
    redirect_to '/login' unless authenticated?
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
