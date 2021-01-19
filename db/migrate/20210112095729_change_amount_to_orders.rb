class ChangeAmountToOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column(:orders, :amoun_cents, :amount_cents)
  end
end
