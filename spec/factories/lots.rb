FactoryBot.define do
  factory :lot do
    title { Faker::Vehicle.manufacture }
    description { 'Lorem ipsum dolor sit amet.' }
    state { 'good' }
    price { 1000 }
  end
end
