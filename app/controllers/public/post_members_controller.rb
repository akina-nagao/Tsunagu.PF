class Public::PostMembersController < ApplicationController
  before_action :authenticate_customer!, only: [:create, :destroy, :update]
  before_action :correct_user, only: [:update]

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

  def new_mail
    @post = Post.find(params[:post_id])
  end

  def create_mail
    @post = Post.find(params[:post_id])
    @title = params[:title]
    @message = params[:message]
    if @title.present? && @message.present?
      @members = Customer.includes(:post_members).where("post_members.status": :permitted, "post_members.post_id": @post.id)
      @members.each do |member|
        GroupMailer.send_group_members(@post, @title, @message, member).deliver
      end
      flash[:success] = "メールを送信しました"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "メールの送信に失敗しました"
      render :new_mail
    end
  end

  private

  def correct_user
    @post_member = PostMember.find_by_id(params[:id])
    redirect_to root_path if @post_member.post.customer != current_customer
  end
end
