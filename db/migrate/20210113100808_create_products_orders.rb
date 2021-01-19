class CreateProductsOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :products_orders do |t|
      t.string :product_sku
      t.monetize :amount, currency: { present: false }
      t.timestamps
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
    end
  end
end
