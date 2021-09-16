# app/controllers/api/v1/restaurants_controller.rb
include MoneyRails::ActionViewExtension
class Api::V1::OrdersController < ApplicationController
    skip_before_action :authenticate_user!

    def show
        @order = Order.find(params[:id])
        # price_object = Money.new(@order.charged_amount_cents, "JPY").exchange_to(@order.payment_currency)
        @price = humanized_money_with_symbol(Money.new(@order.charged_amount_cents, @order.payment_currency))
    end
  
end
