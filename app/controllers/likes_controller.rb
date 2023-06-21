class LikesController < ApplicationController
  load_and_authorize_resource

  def create
    @like = current_user.likes.new
    @like.post_id = params[:post_id]

    if @like.save
      redirect_to user_post_path(current_user, @like.post)
    else
      render :create
    end
  end
end
