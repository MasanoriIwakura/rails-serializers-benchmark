# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Faker::Config.locale = :ja

1000.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email
  )
end

User.find_each do |user|
  10.times do |n|
    Profile.create!(
      hobby: Faker::Lorem.sentence(word_count: 5),
      details: Faker::Lorem.sentence(word_count: 10),
      user: user
    )
  end
end
