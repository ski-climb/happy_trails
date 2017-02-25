class Api::V1::IssuesController < ApplicationController
  def index
    current_id = cookies[:id] ? cookies[:id].to_i : -1
    render json: Issue.all, current_id: current_id
  end
end
