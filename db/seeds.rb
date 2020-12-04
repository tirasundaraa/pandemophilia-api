# frozen_string_literal: true

# Interest
if Interest.none?
  Interest.destroy_all

  INTEREST_NAMES = %i[art sport music movies animal reading writing blogging hiking mystery games finance food photography travel dance].freeze

  INTEREST_NAMES.map do |interest_name|
    Interest.create!(name: interest_name)
  end
end

INTEREST_IDS = Interest.pluck(:id).freeze

User.destroy_all
user = User.create!(
  first_name: 'Bob',
  last_name: 'Allan',
  email: 'bob@example.com',
  phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
  password: '12312312',
  password_confirmation: '12312312',
  bio: 'Animal lover',
  is_pandemophilia: true
)

user.interest_ids = INTEREST_IDS.sample(3)

1.upto(10) do |i|
  image_path = Rails.root.join("db/seed/images/image_#{i}.jpg")

  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    password: '12312312',
    password_confirmation: '12312312',
    bio: Faker::Lorem.sentence,
    is_pandemophilia: i.odd?,
  )

  user.avatar = File.open(image_path)
  user.save

  # inserting user interests
  user.interest_ids = INTEREST_IDS.sample(3)
end
