class ElementsPaymentsController < ApplicationController
    def new
        order = Order.find(params[:order_id])
        line_items_holder = []
        @total_amount = 0
        order.products_orders.each do |products_order|
            @total_amount += products_order.amount * products_order.quantity
        end

        payment_intent = Stripe::PaymentIntent.create({
            amount: @total_amount,
            currency: 'jpy',
            payment_method_types: ['card'],
            customer: current_user.stripe_id,
            # automatic_payment_methods: {
            #     enabled: true,
            # },
        })

        order.update(
            checkout_session_id: nil,
            payment_intent_id: payment_intent.id,
            checkout_amount_cents: @total_amount,
            client_secret: payment_intent.client_secret,
        )
        @order = order
    end

end
