class PaymentsController < ApplicationController
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

    # Stripe.api_version = '2020-08-27; konbini_beta=v2'
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      # payment_method_options: { konbini: {
      #   product_description: 'テスト',
      #   expires_after_days: 3
      #   }
      # },
      customer: current_user.stripe_id,
      line_items: line_items_holder,
      success_url: order_url(order),
      cancel_url: new_cart_url
    )

    order.update(
      checkout_session_id: session.id,
      payment_intent_id: session.payment_intent,
      checkout_amount_cents: @total_amount
    )
    @order = order
    
    #TO DO: Retrieve Payment Method with Customer ID
    #TO DO: Update PaymentIntent with new payment method ID
    # pm_list = Stripe::PaymentMethod.list({
    #   customer: current_user.stripe_id,
    #   type: 'card',
    # })
    
    # if pm_list.data.count > 0
    #   Stripe::PaymentIntent.update(
    #     session.payment_intent,
    #     payment_method: pm_list.data[0].id,
    #   )
    # end

  end
end
