FactoryBot.define do
  factory :user do
    id          { Faker::Lorem.characters(number: 15) }
    currency    {'JPY' }
    language    { 'Japanese' }
  end
end
