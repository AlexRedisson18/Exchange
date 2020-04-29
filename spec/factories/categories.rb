FactoryBot.define do
  factory :category do
    name { Faker::Food.fruits }
  end
end
