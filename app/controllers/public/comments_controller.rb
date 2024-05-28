class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:notice] = "投稿成功！！"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "投稿失敗？！"
      render "public/posts/show"
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy if @comment
    flash[:notice] = "success"
    redirect_to post_path(@post)
  end
  
  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
