class CommentsController < ApplicationController

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = current_user.comments.build(comment_params)
    @comment.blog_id = @blog.id
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to blog_path(@blog), notice: 'コメントの投稿ができませんでした' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントが削除されました'
      format.js { render :index }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:talk)
  end
end
