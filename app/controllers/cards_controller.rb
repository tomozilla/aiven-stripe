class CardsController < ApplicationController
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

    end

    def destroy
        @payment_method = params[:id]
        Stripe::PaymentMethod.detach(
            @payment_method,
          )
        render 'cards/delete_card'
    end

end
