class Public::GuestsController < ApplicationController

  def guest_sign_in
    customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      #customer.skip_confirmation!
      customer.nickname = "ゲスト"
    end
    sign_in customer
    redirect_to root_path
    flash[:notice] = "ゲストユーザーとしてログインしました"
  end
  
end
