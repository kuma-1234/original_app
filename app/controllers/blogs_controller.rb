class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to blogs_path, notice: '新規作成しました！'
    else
      render :new
    end
  end

  def show
    @blog = Blog.find(params[:id])
    @comments = @blog.comments
    @comment = @blog.comments.build
  end

  def edit
    @blog = Blog.find(params[:id])
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
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end


  private

  def blog_params
    params.require(:blog).permit(
      :picture, :content, :work_date, :pesticide_type, :pesticide_name, 
      :flight_speed, :rpm, :shutter_opening, :crop, :variety, :spray_area, {drone_ids: []}
    )
  end
end
