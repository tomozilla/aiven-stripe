class ElementsPaymentsController < ApplicationController
    def new
        order = Order.find(params[:order_id])
        line_items_holder = []
        @total_amount = 0
        order.products_orders.each do |products_order|
            @total_amount += products_order.amount * products_order.quantity
        end
    
        Stripe.api_version = '2020-08-27;automatic_payment_methods_beta=v1'
        payment_intent = Stripe::PaymentIntent.create({
            amount: Money.new(@total_amount, "JPY").exchange_to(order.payment_currency).fractional,
            # amount: @total_amount,
            currency: order.payment_currency,
            # payment_method_types: ['card'],
            # customer: current_user.stripe_id,
            automatic_payment_methods: {
                enabled: true,
            },
        })

        order.update(
            checkout_session_id: nil,
            payment_intent_id: payment_intent.id,
            checkout_amount_cents: @total_amount,
            client_secret: payment_intent.client_secret,
        )
        @current_user = current_user
        @order = order
        unless current_user.default_payment_method.nil?
            @show_card = "Pay NOW with #{current_user.card_type} ending #{current_user.last4}"
        end
    end

    def change_currency
        @order = Order.where(id: params['order']).first
        @order.update!(payment_currency: params['currency'])
        new_currency_price = Money.new(@order.checkout_amount_cents, "JPY").exchange_to(@order.payment_currency)
        Stripe::PaymentIntent.update(
            @order.payment_intent_id,
            currency: @order.payment_currency,
            amount: new_currency_price.fractional
          )
        @price = humanized_money_with_symbol(new_currency_price)
    end

end
