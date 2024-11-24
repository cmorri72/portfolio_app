# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
require 'faker' # Make sure the Faker gem is installed
require 'open-uri' # To open the image URL

# Purge existing profile photos and remove associated blobs and attachments
Customer.find_each do |customer|
  customer.profile_picture.purge if customer.profile_picture.attached?
end

# Ensure there are no orphaned attachments or blobs
ActiveStorage::Blob.where.missing(:attachments).find_each(&:purge)

# Destroy existing records
Build.destroy_all
Customer.destroy_all

50.times do |i|
  customer =Customer.create!(
    first_name: "First #{i + 1}",
    last_name: "Last #{i + 1}",
    email: "customer#{i + 1}@msudenver.edu",
    password: "password",  # Set a default password
    password_confirmation: "password",
    
  )

    # Create a build for the customer
  Build.create!(
    customer: customer,
    email: "customer#{i + 1}@gmail.com",
    active: [true, false].sample,  # Randomly assign true or false for active status
    summary: Faker::Lorem.sentence(word_count: 20),
    skills: Faker::Lorem.words(number: 5).join(", ")
  )


   # Generate a unique profile pic based on the customer's name
  profile_picture_url = "https://robohash.org/#{customer.first_name.gsub(' ', '')}"
  profile_picture = URI.open(profile_picture_url)
  customer.profile_picture.attach(io: profile_picture, filename: "#{customer.first_name}.jpg")
end

puts "50 customers created."