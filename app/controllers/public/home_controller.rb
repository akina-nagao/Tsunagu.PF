class Public::HomeController < ApplicationController
  before_action :redirct_posts_if_current_customer, only: [:top]
  
  def top
  end
  
  def about
  end
  
  def mypage
    @customer = current_customer
    @post_members = @customer.applying_post_members
  end
  
  private
  
  def redirct_posts_if_current_customer
    redirect_to posts_path if current_customer
  end
end
