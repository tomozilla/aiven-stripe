class AddCheckoutAmountToOrder < ActiveRecord::Migration[6.0]
  def change
    add_monetize :orders, :checkout_amount_cents, currency: { present: false }
  end
end
