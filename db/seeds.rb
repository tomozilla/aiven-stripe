puts 'Cleaning database...'
ProductsOrder.delete_all
Order.destroy_all
Product.destroy_all
Category.destroy_all

puts 'Creating categories...'
electronics = Category.create!(name: 'electronics')
clothes = Category.create!(name: 'clothes')

puts 'Creating products...'
Product.create!(price: 500, sku: 'mouse', name: 'Computer Mouse', category: electronics, photo_url: 'https://images.pexels.com/photos/392018/pexels-photo-392018.jpeg?cs=srgb&dl=pexels-vojtech-okenka-392018.jpg&fm=jpg')
Product.create!(price: 20000, sku: 'jeans', name: 'Jeans', category: clothes, photo_url: 'https://images.pexels.com/photos/1082529/pexels-photo-1082529.jpeg?cs=srgb&dl=pexels-mica-asato-1082529.jpg&fm=jpg')
Product.create!(price: 4000, sku: 'headphone',   name: 'Headphone',      category: electronics, photo_url: 'https://images.pexels.com/photos/1591/technology-music-sound-things.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
puts 'Finished!'