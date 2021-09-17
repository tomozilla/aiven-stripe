class StripePaymentFailedService
  def call(event)
    puts ("==========")
    # puts (event)
    puts ("==========")
    order = Order.find_by(payment_intent_id: event.data.object.id)
    puts (order.payment_intent_id)
    redirect_to root_path
  end
end
