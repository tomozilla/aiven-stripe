class AddColumnsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :charge_id, :string
    remove_column :orders, :product_sku, :string
    rename_column(:orders, :amount_cents, :amount_cents_charged)
  end
end
