class Public::CustomersController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    if @customer.update(customer_params)
      redirect_to mypage_path
      flash[:notice] = "登録情報が更新されました。"
    else
      render :edit
    end
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email)
  end
  
  def is_matching_login_customer
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to posts_path
    end
  end
  
end
