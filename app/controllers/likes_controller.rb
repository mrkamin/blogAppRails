class LikesController < ApplicationController
  load_and_authorize_resource

  def index
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @likes = post.likes

    respond_to do |format|
      format.html
      format.json { render json: @likes, status: 200 }
    end
  end

  def create
    @like = current_user.likes.new
    @like.post_id = params[:post_id]

    if @like.save
      respond_to do |format|
        format.html { redirect_to user_post_path(current_user, @like.post) }
        format.json { render json: @like, status: 200 }
      end
    else
      respond_to do |format|
        format.html { render :create }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end
end
