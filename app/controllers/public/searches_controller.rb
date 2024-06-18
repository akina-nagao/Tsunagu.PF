class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'customer'
      @records = Customer.search_for(@content, @method)
    else
      @records = Product.search_for(@content, @method)
    end
  end
  
  #def search
  #  if params[:keyword].present?
  #    @posts = Post.where('caption LIKE ?', "%#{params[:keyword]}%")
  #    @keyword = params[:keyword]
  #  else
  #    @posts = Post.all
  #  end
  #end
  
end
