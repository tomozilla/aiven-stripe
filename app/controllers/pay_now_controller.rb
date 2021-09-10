class PayNowController < ApplicationController
    def create
        order = Order.find(params[:order_id])
        line_items_holder = []
        @total_amount = 0
        order.products_orders.each do |products_order|
            @total_amount += products_order.amount * products_order.quantity
        end

        begin
            payment_intent = Stripe::PaymentIntent.create({
                amount: @total_amount,
                currency: 'jpy',
                payment_method_types: ['card'],
                customer: current_user.stripe_id,
                payment_method: current_user.default_payment_method,
                off_session: true,
                confirm: true,
            })

            order.update(
                checkout_session_id: nil,
                payment_intent_id: payment_intent.id,
                checkout_amount_cents: @total_amount,
                client_secret: payment_intent.client_secret,
            )

            redirect_to order_path(order)

        rescue Stripe::CardError => e
            # Error code will be authentication_required if authentication is needed
            puts "Error is: \#{e.error.code}"
            payment_intent_id = e.error.payment_intent.id
            payment_intent = Stripe::PaymentIntent.retrieve(payment_intent_id)

            order.update(
                checkout_session_id: nil,
                payment_intent_id: payment_intent.id,
                checkout_amount_cents: @total_amount,
                client_secret: payment_intent.client_secret,
            )

            # TO DO: Create path for re-autorization 
            if e.error.code == 'authentication_required'
                redirect_to order_path(order)
            end
        end

    end
end
