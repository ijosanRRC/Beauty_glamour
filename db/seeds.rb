# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development? && AdminUser.find_by(email: 'admin@example.com').nil?
require 'csv'
require 'faker'


5.times do
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
  )
end
CSV.foreach(Rails.root.join('db', 'products.csv'), headers: true) do |row|
  puts "Category name from CSV: #{row['Label']}"
  category = Category.create(name: row['Brand'])

  if category.persisted?
    puts "Successfully added category: #{category.name}"
  else
    puts "Error creating category: #{category.inspect}"
    category.errors.full_messages.each do |error|
      puts "- #{error}"
    end
  end
end



counter = 0

CSV.foreach(Rails.root.join('db', 'products.csv'), headers: true) do |row|
  break if counter >= 100

  product = Product.create(name: row['Name'], description: row['Ingredients'],  category: Category.find_by(name: row['']), price: row['Price'])

  if product.save
    puts "Successfully added product: #{product.name}"
    counter += 1
  else
    product.errors.full_messages.each do |error|
      puts "- #{error}"
    end
  end
end


Product.all.each do |product|
  rand(1..5).times do
    Review.create!(
      product: product,
      user: User.all.sample,
    )
  end
end

# Seed Orders and OrderItems
puts 'Seeding Orders and OrderItems...'
# Replace this block with your code to fetch orders and order items from Faker.
# For example:
User.all.each do |user|
  order = Order.create!(user: user)
  Product.all.sample(rand(1..5)).each do |product|
    quantity = rand(1..5)
    OrderItem.create!(
      order: order,
      product: product,
      quantity: quantity,
    )
  end
end

puts 'Seeding completed!'
