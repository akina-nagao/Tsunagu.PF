class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!, only: [:create, :destroy]

  def create
    post = Post.find(params[:post_id])
    current_customer.favorite(post)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_customer.unfavorite(post)
    redirect_back(fallback_location: root_url)
  end
end
