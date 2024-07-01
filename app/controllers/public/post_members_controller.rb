class Public::PostMembersController < ApplicationController
  def new
    @post_member = Post_member.new
    @post_member.customers << current_customer
  end
  
  def create
    post = Post.find(params[:post_id])
    current_customer.join_member(post)
    flash[:notice] = "グループへ申請しました"
    redirect_back(fallback_location: root_url)
  end
  
  def index
    post_members = PostMember.includes(:post, :customer).where('posts.customer_id': current_customer.id)
    @post_members = post_members.where(status: :permitted).order(post_id: :asc)
    @ng_post_members = post_members.where(status: :excluded).order(post_id: :asc)
  end
  
  def destroy
    post = Post.find(params[:post_id])
    current_customer.detach_member(post)
    flash[:notice] = "グループから退会しました"
    redirect_back(fallback_location: root_url)
  end
  
  def update
    @post_member = PostMember.find(params[:id])
    @post_member.update(status: params[:status])
    redirect_back(fallback_location: root_url)
  end

end
