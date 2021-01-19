class Order < ApplicationRecord
  belongs_to :user
  monetize :checkout_amount_cents
  monetize :charged_amount_cents
  has_many :products_orders
end
