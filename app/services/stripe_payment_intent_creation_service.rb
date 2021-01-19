class StripePaymentIntentCreationService
  def call(event)
    order = Order.find_by(payment_intent_id: event.data.object.id)
    #    order.update(state: 'pending') unless order.state == 'paid'
  end
end
