class Product < ApplicationRecord
  belongs_to :category
  monetize :price_cents
  has_many :products_orders
  after_create :create_stripe_product
  
  def create_stripe_product
    product = Stripe::Product.create({
      name: self.name,
      images: [self.photo_url]
      })
      
    Stripe::Price.create({
      unit_amount: self.price_cents,
      currency: 'jpy',
      product: product.id
    })
    
  end
  
end
