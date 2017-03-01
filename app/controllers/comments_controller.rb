class CommentsController < ApplicationController

  def create
    @issue = Issue.find(params[:issue_id])
    @comment = @issue.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to issue_path(@issue), success: "Comment added"
    else
      redirect_to issue_path(@issue), danger: "Comment body can't be blank"
    end
  end

  private 

    def comment_params
      params.require(:comment).permit(:body)
    end
end
