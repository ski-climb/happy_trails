class Api::V1::RecentRoutesController < ApplicationController
  def index
    token = set_token
    routes = StravaService.recent_routes(token)
    render json: routes
  end

  private

    def set_token
      user_id = params[:user_id]
      if User.exists?(user_id)
        User.find(user_id).token
      else
        ''
      end
    end
end
