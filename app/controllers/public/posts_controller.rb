class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :create, :edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @tag = Tag.new
  end

  def create
    @post = Post.new(post_params)

    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to posts_path
    else
      @posts = Post.all
      @posts = @posts.page(params[:page])
      flash.now[:alert] = "投稿に失敗しました"
      render :index
    end
  end

  def index
    @customer = current_customer
    @post = Post.new
    @posts = Post.joins(:customer)
    if params[:keyword].present?
      @posts = @posts.where('title LIKE ?', "%#{params[:keyword]}%")
              .or(@posts.where('body LIKE ?', "%#{params[:keyword]}%"))
              .or(@posts.where('customers.nickname LIKE ?', "%#{params[:keyword]}%" ))
    end
    @posts = @posts.includes(:tags).where('tags.id': params[:tag_id]) if params[:tag_id].present?
    @posts = @posts.order(created_at: :desc)
    @posts = @posts.page(params[:page])

  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit

  end

  def update
    if @post.update(post_params)
      flash[:notice] = "投稿の更新に成功しました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy if @post
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end


  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :profile_image, :tag_name)
  end

  def correct_user
    @post = current_customer.posts.find_by_id(params[:id])
    redirect_to root_path if !@post
  end
end
