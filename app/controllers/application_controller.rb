class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user
  before_action :authorize!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize!
    render file: 'public/404', status: 404 unless authorized?
  end

  def authorized?
    Permission.new(current_user, params[:controller], params[:action]).authorized?
  end
end
