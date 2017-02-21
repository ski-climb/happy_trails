class Api::V1::IssuesController < ApplicationController
  def index
    render json: Issue.all
  end
end