class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:notice] = "コメントに成功しました"
      redirect_to post_path(@post)
    else
      @comments = @post.comments.order(created_at: :desc)
      flash.now[:alert] = "コメントに失敗しました"
      render "public/posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
   
    @comment.destroy if @comment
    flash[:notice] = "コメントを削除しました"
    redirect_to post_path(@post)
  end
  
  def destroy_confirm
    @customer = current_customer
  end

  def destroy_customer
    @customer = current_customer
    if @customer.email == 'guest@example.com'
      reset_session
      redirect_to :root
    else
      @customer.update(is_valid: false)
      reset_session
      redirect_to :root
    end
  end
  

  private
  def comment_params
    params.require(:comment).permit(:comment, :image)
  end
  
  def correct_user
     @comment = current_customer.comments.find_by_id(params[:id])
     redirect_to root_path if !@comment
  end
end
