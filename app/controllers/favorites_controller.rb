class FavoritesController < ApplicationController

  def create
    @blog = Blog.find(params[:blog_id])
    @favorite = Favorite.new(user_id: current_user.id, blog_id: @blog.id)
    @favorite.save
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    @favorite = Favorite.find_by(user_id: current_user.id, blog_id: @blog.id)
    @favorite.destroy
  end
end
