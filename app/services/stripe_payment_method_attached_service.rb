class StripePaymentMethodAttachedService
  def call(event)
    customer = User.find_by(stripe_id: event.data.object.customer)
    if customer.default_payment_method.nil?
      customer.update(default_payment_method: event.data.object.id, card_type: event.data.object.card.brand, last4: event.data.object.card.last4)
    end
  end
end
