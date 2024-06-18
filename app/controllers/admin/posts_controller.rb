class Admin::PostsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  def index
    @posts = Post.all
  end
  
  def destroy
    @post = Post.find_by_id(params[:id])
    @post.destroy if @post
    flash[:success] = "success"
    redirect_to admin_posts_path
  end
end
