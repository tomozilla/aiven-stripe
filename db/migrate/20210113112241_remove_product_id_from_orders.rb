class RemoveProductIdFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_reference(:orders, :product, index: true, foreign_key: true)
  end
end
