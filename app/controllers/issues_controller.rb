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
    if set_issue_gps_data && @issue.save
      save_photo_and_redirect_to_root
    elsif @issue.save
      save_photo_and_redirect_to_add_gps_data
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

    def set_issue_gps_data
      if params["image"] && gps_data = EXIFR::JPEG.new(image_params.open).gps
        @issue.assign_attributes(latitude: gps_data.latitude, longitude: gps_data.longitude)
        return true
      end
    end

    def set_issue
      @issue = Issue.find(params[:id])
    end

    def add_photo
      @issue.photos.create(url: image_params, user: current_user)
    end

    def save_photo_and_redirect_to_root
      add_photo
      redirect_to root_path, success: 'Issue added.'
    end

    def save_photo_and_redirect_to_add_gps_data
      add_photo
      flash[:warning] = 'Could not find GPS data from image. Please select the issue location by dragging the blue dot to its location and clicking submit location.'
      redirect_to edit_issue_path(@issue)
    end
end
