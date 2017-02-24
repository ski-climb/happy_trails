class Api::V1::RecentRoutesController < ApplicationController
  def index
    token = current_person.token
    routes = StravaService.recent_routes(token)
    render json: routes
  end
end
