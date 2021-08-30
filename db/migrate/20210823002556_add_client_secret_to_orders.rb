class AddClientSecretToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :client_secret, :string
  end
end
