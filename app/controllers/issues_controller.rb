class IssuesController < ApplicationController

  before_action :set_issue, only: [:edit, :show]

  def index
    @issue = Issue.last
  end

  def new
    @issue = Issue.new
  end

  def show
  end

  def edit 
  end

  def create
    @issue = current_user.issues.new(issue_params)
    if @issue.save
      photo_service = PhotoService.new(image_params, @issue, current_user)
      redirect_to photo_service.path, info: photo_service.flash
    else
      render :new
    end
  end

  def update
    issue = Issue.find(params[:id])
    latitude, longitude = params[:coordinates].split
    issue.update(latitude: latitude, longitude: longitude)
    render :js => "window.location = '#{root_path}'"
  end

  private

    def issue_params
      params.require(:issue).permit(:title, :description,
        :severity, :category)
    end

    def image_params
      params["image"].first
    end

    def set_issue
      @issue = Issue.find(params[:id])
    end
end
