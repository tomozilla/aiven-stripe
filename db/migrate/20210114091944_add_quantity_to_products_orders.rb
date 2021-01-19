class AddQuantityToProductsOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :products_orders, :quantity, :integer
  end
end
