# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create(email: "test@example.com")

categories = %w[Food Rent Transport Entertainment Salary]
categories.each { |name| Category.create(name: name) }

Transaction.create!(
  user: user,
  category: Category.find_by(name: "Food"),
  amount: 25.50,
  description: "Lunch",
  transaction_type: "expense",
  date: Date.today
)
