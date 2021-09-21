class StripePaymentFailedService
  def call(event)
    order = Order.find_by(payment_intent_id: event.data.object.id)
  end
end
