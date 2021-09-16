class AddPaymentCurrencyToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :payment_currency, :string
  end
end
