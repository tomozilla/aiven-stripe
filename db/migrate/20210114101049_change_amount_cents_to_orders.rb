class ChangeAmountCentsToOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :amount_cents_charged, :amount_cents
  end
end
