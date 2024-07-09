class Public::HomeController < ApplicationController
  before_action :redirct_posts_if_current_customer, only: [:top]
  
  def top
  end
  
  def about
  end
  
  def mypage
    @customer = current_customer
    @post_members = @customer.applying_post_members
    
    @customers = Customer.all
    @post = Post.all
    @posts= Post.all
  end
  
  def guest_sign_in
    customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.nickname = "ゲスト"
    end
    sign_in customer
    redirect_to root_path
    flash[:notice] = "ゲストユーザーとしてログインしました"
  end
    
  private
  
  def redirct_posts_if_current_customer
    redirect_to posts_path if current_customer
  end
end
