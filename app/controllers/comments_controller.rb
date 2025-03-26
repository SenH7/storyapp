class CommentsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: "Comment added."
    else
      redirect_to post_path(@post), alert: "Comment cannot be empty."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user == @comment.user || current_user == @comment.post.user
      @comment.destroy
      redirect_to post_path(@comment.post), notice: "Comment deleted."
    else
      redirect_to post_path(@comment.post), alert: "You are not authorized to delete this comment."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
