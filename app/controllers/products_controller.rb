class ProductsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @products = Product.all
  end

  def show
    @product = nil
    @product = Product.find(params[:id]) if Product.where(id: params[:id]).exists?
  end
end