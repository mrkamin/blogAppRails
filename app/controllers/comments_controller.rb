class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      # redirect_to previous url link or page if available
      redirect_to request.referrer
    else
      render :create
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    # redirect_to previous url link or page if available
    redirect_to request.referrer
  end

  private :comment_params
end
