class IssuesController < ApplicationController

  def index
    @issue = Issue.last
  end

  def new
    @issue = Issue.new
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def edit 
    @issue = Issue.find(params[:id])
  end

  def create
    @issue = current_user.issues.new(issue_params)
    if set_issue_gps_data && @issue.save
      @issue.photos.create(url: image_params, user: current_user)
      redirect_to root_path, success: 'Issue added.'
    elsif @issue.save
      @issue.photos.create(url: image_params, user: current_user)
      flash[:warning] = 'Could not find GPS data from image. Please select the issue location using the map.'
      redirect_to edit_issue_path(@issue)
    else
      render :new
    end
  end

  def update
    issue = Issue.find(params[:id])
    coordinates = params[:coordinates].split
    latitude = coordinates.first
    longitude = coordinates.last
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
end
