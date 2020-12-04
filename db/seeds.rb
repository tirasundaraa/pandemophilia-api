# frozen_string_literal: true

100.times do |i|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    password: '12312312',
    password_confirmation: '12312312',
    bio: Faker::Lorem.sentence,
    is_pandemophilia: i.odd?
  )
end
