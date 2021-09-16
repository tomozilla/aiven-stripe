include MoneyRails::ActionViewExtension
class CartsController < ApplicationController

  before_action :set_products_order, only: [:update, :delete]

  def new
    @current_user = current_user
    if current_user.orders.where(state: 'cart').empty?
      @cart_order = Order.create!(state: 'cart', user: current_user)
    else
      @cart_order = current_user.orders.where(state: 'cart').first
    end
  end

  def update
    if params['sign'].to_i == 1
      @target_products_order.quantity += 1
    elsif params['sign'].to_i == -1 && @target_products_order.quantity > 1
      @target_products_order.quantity -= 1
    end
    @target_products_order&.save
    render 'carts/update_product'
  end

  def delete
    @target_products_order.delete
    @only_product = true
    @only_product = false if current_user.orders.where(state: 'cart').first.products_orders.exists?
    render 'carts/delete_product'
  end

  private

  def set_products_order
    @target_products_order = current_user.orders.where(state: 'cart').first
                                         .products_orders.find(params['products_order'].to_i)
  end
end
