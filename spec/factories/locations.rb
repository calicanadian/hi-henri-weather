FactoryBot.define do
  factory :location do
    sequence(:lon) { Faker::Address.longitude }
    sequence(:lat) { Faker::Address.latitude }
    sequence(:zipcode) { Faker::Address.zip_code }
    sequence(:country) { Faker::Address.country }
    sequence(:city) { Faker::Address.city }
    sequence(:display_order) { 1 }
    sequence(:temperature) { Faker::Number.decimap(l_digits: 3, r_digits: 2) }
    sequence(:temp_min) { Faker::Number.decimap(l_digits: 3, r_digits: 2) }
    sequence(:temp_max) { Faker::Number.decimap(l_digits: 3, r_digits: 2) }
    sequence(:temp_avg) { Faker::Number.decimap(l_digits: 3, r_digits: 2) }
  end
end
