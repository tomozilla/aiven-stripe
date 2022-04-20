class CheckoutCurrencyController < ApplicationController
  def new
    order = Order.find(params[:order_id])
    line_items_holder = []
    @total_amount = 0
    order.products_orders.each do |products_order|
      line_items_holder <<
        {
          name: products_order.product.sku,
          images: [products_order.product.photo_url],
          amount: products_order.product.price_cents,
          currency: 'jpy',
          quantity: products_order.quantity,
        }
      @total_amount += products_order.amount * products_order.quantity
    end

    order.update(
      checkout_amount_cents: @total_amount,
      client_secret: nil,
    )
 
    @current_user = current_user
    @order = order
  end

  def change_currency
    @order = Order.where(id: params['order']).first
    @order.update!(payment_currency: params['currency'])
    new_currency_price = Money.new(@order.checkout_amount_cents, "JPY").exchange_to(@order.payment_currency)
    @price = humanized_money_with_symbol(new_currency_price)
  end 
end
