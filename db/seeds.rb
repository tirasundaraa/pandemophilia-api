# frozen_string_literal: true

100.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    password: 'password123',
    password_confirmation: 'password123',
    bio: Faker::Lorem.sentence
  )
end
