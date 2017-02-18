class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_post_comment_url
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id, :parent_comment_id)
  end
end
