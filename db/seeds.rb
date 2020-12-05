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

user = User.create!(
  first_name: 'Bob',
  last_name: 'Allan',
  email: 'bob@example.com',
  phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
  password: '12312312',
  password_confirmation: '12312312',
  bio: Faker::Quote.most_interesting_man_in_the_world,
  is_pandemophilia: true,
  avatar: 'https://media4.s-nbcnews.com/j/newscms/2019_45/3082841/191104-jungkook-bts-cs-1022a_07aaee52b9a979bada7386d8b5934c84.fit-760w.jpg'
) unless User.find_by(email: 'bob@example.com')
user.interest_ids = INTEREST_IDS.sample(3)

IMAGE_URLS = %w[
  https://www.deccanherald.com/sites/dh/files/styles/article_detail/public/article_images/2020/05/19/file78t1uwxtc48ldc0s1z6-1879176103-1578811466.jpg
  https://ecs7.tokopedia.net/img/cache/700/product-1/2019/7/26/427597413/427597413_3c8de548-b2c5-4fd0-97a2-8779823883bd_505_505.jpg
  https://vignette.wikia.nocookie.net/marvelhigh/images/b/bd/SteveRogers.jpg
  https://pm1.narvii.com/6601/43be66544ff4327187cc626851c134cedd58f96f_00.jpg
  https://www.refinery29.com/images/9529993.jpg
  https://www.screengeek.net/wp-content/uploads/2019/08/spider-man-3-peter-parker.jpg
  https://a.wattpad.com/cover/161298582-288-k521610.jpg
  https://static.wikia.nocookie.net/ironman/images/7/79/Photo%28906%29.jpg
  https://pbs.twimg.com/profile_images/708439512817471488/engvIr2L_400x400.jpg
  https://sites.rutgers.edu/demo-project/wp-content/uploads/sites/16/2017/12/christopher-reeve-superman.jpg
].freeze

User.destroy_all

10.times do |i|
  image_url = IMAGE_URLS[i]

  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    password: '12312312',
    password_confirmation: '12312312',
    bio: Faker::Quote.most_interesting_man_in_the_world,
    is_pandemophilia: i.odd?,
    avatar: image_url
  )

  # user.avatar = File.open(image_path)
  user.save

  # inserting user interests
  user.interest_ids = INTEREST_IDS.sample(3)
end
