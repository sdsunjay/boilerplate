# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
users = Dir[File.join(Rails.root, 'db', 'seeds', "users.rb")][0]
puts "Seeding #{users}..."
load(users) if File.exist?(users)

products = Dir[File.join(Rails.root, 'db', 'seeds', "products.rb")][0]
puts "Seeding #{products}..."
load(products) if File.exist?(products)
