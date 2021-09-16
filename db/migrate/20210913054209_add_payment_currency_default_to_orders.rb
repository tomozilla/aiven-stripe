class AddPaymentCurrencyDefaultToOrders < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:orders, :payment_currency, from: nil, to: "jpy")
  end
end
