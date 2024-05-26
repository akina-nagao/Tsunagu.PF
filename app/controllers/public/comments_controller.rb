class Customer::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_customer.comment(post)
    redirect_to post_path(post)
  end
  
  def destroy
    post = Post.find(params[:post_id])
    current_customer.comments(post)
    redirect_back(fallback_location: root_url)
  end
  
end
