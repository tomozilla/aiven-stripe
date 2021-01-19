class OrdersController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    if current_user.orders.where(state: 'cart').empty?
      order = Order.create!(state: 'cart', user: current_user)
    else
      order = current_user.orders.where(state: 'cart').first
    end
    if ProductsOrder.where(product: product, order: order).exists?
      products_order = ProductsOrder.where(product: product, order: order).first
      products_order.quantity += 1
    else
      products_order = ProductsOrder.new
      products_order.order = order
      products_order.product = product
      products_order.amount_cents = product.price_cents
      products_order.product_sku = product.sku
      products_order.quantity = 1
    end
    products_order.save
    redirect_to new_cart_path
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
