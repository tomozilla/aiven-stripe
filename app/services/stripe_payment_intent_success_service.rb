class StripePaymentIntentSuccessService
  def call(event)
    order = Order.find_by(payment_intent_id: event.data.object.id)
    order.update(state: 'paid', charged_amount_cents: event.data.object.amount, charge_id: event.data.object.charges.data[0].id)
  end
end
