class IssuesController < ApplicationController
  def new
    @issue = Issue.new
  end

  def create
    @issue = current_user.issues.new(issue_params)
    if @issue.save
      redirect_to root_path
      # redirect_to root_path, success: 'Issue added.'
    else
      render :new
    end
  end

  private

    def issue_params
      params.require(:issue).permit(:title, :description,
        :severity, :category, :latitude, :longitude)
    end
end