class FavoritesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])

    authorize! :create, Favorite, message: "You cannot do that"
    favorite = current_user.favorites.create(post: @post)
    if favorite.valid?
      redirect_to [@topic, @post], notice: "Favorited post"
    else
      redirect_to [@topic, @post], error: "Unable to add favorite. Please try again."
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find(params[:id])

    authorize! :destroy, @favorite, message: "You cannot do that"
    if @favorite.destroy
      redirect_to [@topic, @post], notice: "Removed favorite."
    else
      redirect_to [@topic, @post], error: "Unable to remove favorite. Please try again."
    end
  end
end
