class IssuesController < ApplicationController
  def new
    @issue = Issue.new
  end

  def create
    @issue = current_user.issues.new(issue_params)
    if @issue.save
      @issue.photos.create(url: image_params, user: current_user)
      redirect_to root_path, success: 'Issue added.'
    else
      render :new
    end
  end

  private

    def issue_params
      params.require(:issue).permit(:title, :description,
        :severity, :category, :latitude, :longitude)
    end

    def image_params
      params["image"].first
    end
end
