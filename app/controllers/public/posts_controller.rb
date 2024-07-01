class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :create, :edit, :update, :destroy]
  
  def new
    @post = Post.new
    @tag = Tag.new
  end

  def create
    @post = Post.new(post_params)
    #tag_names = params[:tag_name].split(",")
    #tags = tag_names.map { |tag_name| Tag.find_or_initialize_by(name: tag_name) }
    #tag.each do |tag|
    #  if tag.invalid?
    #    @tag_name = params[:tag_name]
    #    @post.errors.add(:tags, tag.errors.full_messages.join("\n"))
    #    render render :new, status: :unprocessable_entity
    #  end
    #end
    
    #@post.tags = tags
    #if @post.save
    #  redirect_to @post, notice: "Post was successfully created."
    #else
    # @tag_name = params[:tag_name]
    #  render :new, status: :unprocessable_entity
    #end
    
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to posts_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def index
    @posts = Post.all
    if params[:keyword].present?
      @posts = @posts.where('title LIKE ?', "%#{params[:keyword]}%")
              .or(@posts.where('body LIKE ?', "%#{params[:keyword]}%"))
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿の更新に成功しました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.customer != current_customer
       redirect_to posts_path
    else
      @post.destroy
    end
  end


  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :tag_name)
  end

end
