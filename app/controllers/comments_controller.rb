class CommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:create]
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user

    if @comment.save
      redirect_to :back, notice: 'Your comment was successfully posted!'
    else
      redirect_to :back, notice: "Your comment wasn't posted!"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    if @comment.destroy
      redirect_to :back, notice: "Comment deleted."
    end
  end
  private

  def comment_params
    params.require(:comment).permit(:campaign_id, :body, :user_id)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Campaign.find_by_id(params[:campaign_id]) if params[:campaign_id]
  end

end