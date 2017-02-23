class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(email: params[:email])
    if admin && admin.authenticate(params[:password])
      successful_login(admin)
    else
      unsuccessful_login
    end
  end

  private
    def successful_login(admin)
      reset_session
      session[:admin_id] = admin.id 
      redirect_to root_path, info: "Welcome, #{admin.first_name}!"
    end

    def unsuccessful_login
      flash.now[:info] = 'Invalid email or password.'
      render :new
    end
end
