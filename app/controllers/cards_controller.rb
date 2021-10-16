class CardsController < ApplicationController
    #skip_before_action :verify_authenticity_token
    def index
        customer = Stripe::Customer.retrieve(current_user.stripe_id)
        payment_methods = Stripe::PaymentMethod.list({
            customer: current_user.stripe_id,
            type: 'card',
          })
        @pm_list = payment_methods.data
        @default_pm = current_user.default_payment_method
        @intent = Stripe::SetupIntent.create({
            customer: customer.id,
        })

        stripe_id = current_user.stripe_id
        @session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            mode: 'setup',
            customer: stripe_id,
            success_url: 'http://localhost:3000/cards',
            cancel_url: 'http://localhost:3000/cards',
        )

    end

    def update
        payment_method = params[:id]
        new_pm = Stripe::PaymentMethod.retrieve(
            payment_method,
          )
        current_user.default_payment_method = payment_method
        current_user.card_type = new_pm.card.brand
        current_user.last4 = new_pm.card.last4
        current_user.save!
        render 'cards/update_payment_method'
    end

    def destroy
        @payment_method = params[:id]
        Stripe::PaymentMethod.detach(
            @payment_method,
          )
        render 'cards/delete_card'
    end

end
