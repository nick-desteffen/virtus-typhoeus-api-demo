100.times do
  user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.free_email, password: "password", password_confirmation: "password")
  user.addresses.create(street1: Faker::Address.street_address, street2: Faker::Address.secondary_address, city: Faker::Address.city, state: Faker::Address.us_state, zip_code: Faker::Address.zip_code)
end
