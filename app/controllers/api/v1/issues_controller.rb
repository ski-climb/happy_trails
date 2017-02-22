class Api::V1::IssuesController < ApplicationController
  def index
    current_id = current_user.id if current_user
    render json: Issue.all, current_id: current_id
  end
end
