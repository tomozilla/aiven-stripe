class ChangeCheckoutAmountCentsToOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :checkout_amount_cents_cents, :checkout_amount_cents
  end
end
