class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer != current_customer
      redirect_to mypage_path
      flash[:notice] = "不正なアクセスです。"
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to mypage_path
      flash[:notice] = "登録情報が更新されました。"
    else
      render customer_path
    end
  end

  def destroy_confirm
    @customer = current_customer
  end

  def destroy_customer
    @customer = current_customer
    if @customer.email == 'guest@example.com'
      reset_session
      redirect_to :root
    else
      @customer.update(is_valid: false)
      reset_session
      redirect_to :root
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :email, :profile_image)
  end


end
