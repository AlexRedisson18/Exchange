FactoryBot.define do
  factory :lot do
    title { Faker::Vehicle.manufacture }
    description { 'Lorem ipsum dolor sit amet.' }
    state { 'good' }
    price { 1000 }
    category { '' }
  end

  factory :invalid_lot, parent: :lot do
    title { nil }
  end
end
