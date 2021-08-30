class AddCardToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :default_payment_method, :string
    add_column :users, :card_type, :string
    add_column :users, :last4, :string
  end
end
