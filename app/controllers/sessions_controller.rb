class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = user.id
    redirect_to root_path, info: "Welcome #{user.first_name}!"
  end

  def destroy
    reset_session
    redirect_to root_path, info: 'You are now logged out.'
  end

  private

    def auth_hash
      request.env['omniauth.auth']
    end
end
