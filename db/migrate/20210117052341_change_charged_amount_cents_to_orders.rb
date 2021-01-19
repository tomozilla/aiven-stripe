class ChangeChargedAmountCentsToOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :amount_cents, :charged_amount_cents
  end
end
