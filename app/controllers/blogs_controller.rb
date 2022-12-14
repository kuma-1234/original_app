class BlogsController < ApplicationController

  def index
    @q = Blog.status_public.includes(:user, :match_drones, :drones).ransack(params[:q])
    @blogs = @q.result(distinct: true).order('created_at desc')
    @q = Blog.ransack
  end

  def new
    @blog = Blog.new
  end

  def show
    @blog = Blog.includes(:user, :drones).find(params[:id])
    @comments = @blog.comments
    @comment = @blog.comments.build
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)

    if @blog.status_private? && @blog.user != current_user
      redirect_to blogs_path, notice: 'このページにはアクセスできません！'
    end
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to blogs_path, notice: '新規作成しました！'
    else
      render :new
    end
  end

  def edit
    @blog = Blog.find(params[:id])
    if current_user.id != @blog.user_id
      redirect_to blogs_path, notice: '他のユーザーの日記は編集できません！'
    end
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: '編集しました！'
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    if current_user.id == @blog.user_id
      @blog.destroy
      redirect_to blogs_path, notice: 'ブログを削除しました！'
    else
      redirect_to blogs_path, notice: '他のユーザーの日記は削除できません！'
    end
  end

  def yourself_blog
    @search = Blog.where(user_id: current_user.id).includes(:user, :match_drones, :drones).ransack(params[:q])
    @blogs = @search.result(distinct: true).order('created_at desc')
    @search = Blog.where(user_id: current_user.id).ransack
  end

  def other_blog
    @blogs = Blog.status_public.where(user_id: params[:id]).includes(:user, :match_drones, :drones).order('created_at desc')
    @blog = @blogs.find_by(user_id: params[:id])
  end


  private

  def blog_params
    params.require(:blog).permit(
      :picture, :content, :work_date, :pesticide_type, :pesticide_name,
      :flight_speed, :rpm, :shutter_opening, :crop, :variety, :spray_area, :status, { drone_ids: [] }
    )
  end
end
