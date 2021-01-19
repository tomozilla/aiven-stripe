  class Product < ApplicationRecord
  belongs_to :category
  monetize :price_cents
  has_many :products_orders
end
