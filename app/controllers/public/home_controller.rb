class Public::HomeController < ApplicationController
  def top
  end
  
  def about
  end
  
  def mypage
    @customer = current_customer
    @post_members = @customer.applying_post_members
  end
end
