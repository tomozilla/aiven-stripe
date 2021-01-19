class CartsController < ApplicationController
  def new
    if current_user.orders.where(state: 'cart').empty?
      @cart_order = Order.create!(state: 'cart', user: current_user)
    else
      @cart_order = current_user.orders.where(state: 'cart').first
    end
  end

  def update
    @new_products_order = ProductsOrder.find(params['products_order'].to_i)
    if params['sign'] == 'plus'
      @new_products_order.quantity += 1
    elsif params['sign'] == 'minus' && @new_products_order.quantity > 1
      @new_products_order.quantity -= 1
    end
    @new_products_order&.save
    render 'carts/update_product'
  end

  def delete
    @deleting_products_order_id = ProductsOrder.find(params['products_order'].to_i).id
    ProductsOrder.find(params['products_order'].to_i).delete
    @only_product = true
    @only_product = false if current_user.orders.where(state: 'cart').first.products_orders.exists?
    render 'carts/delete_product'
  end
end
