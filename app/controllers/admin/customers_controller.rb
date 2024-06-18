class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"
  
  
  def index
    @customers = Customer.all
  end
  
  def destroy
    @customer = Customer.find_by_id(params[:id])
    @customer.destroy if @customer
    flash[:success] = "success"
    redirect_to admin_customers_path
  end
end
