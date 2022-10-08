FactoryBot.define do
  factory :subscription do
    name { Faker::Lorem.characters(number: 100) }
    price { Faker::Number.between(from: 0, to: 10000) }
    first_payment_date { Faker::Date.between(from: '2020-10-15', to: '2030-10-15') }
    # first_payment_date { 'Fri, 28 Oct 2022' }
    # first_payment_date { '2022-10-15' }
    remarks { Faker::Lorem.characters(number: 100) }
    is_paused { Faker::Boolean.boolean }
    image_url { Faker::Lorem.characters(number: 100) }
    payment_cycle { 'oneMonth' }
    payment_method { 'card' }
    association :user
  end
end
