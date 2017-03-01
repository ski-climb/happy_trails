class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user,
                :current_user?,
                :current_person,
                :current_admin
  before_action :authorize!

  def current_user?
    !! current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def current_person
    current_user || current_admin
  end

  def authorize!
    render file: 'public/404', status: 404 unless authorized?
  end

  def authorized?
    Permission.new(current_person, params[:controller], params[:action]).authorized?
  end
end
