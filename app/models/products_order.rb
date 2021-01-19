class ProductsOrder < ApplicationRecord
  belongs_to :order
  belongs_to :product
  monetize :amount_cents
end
