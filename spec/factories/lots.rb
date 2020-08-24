FactoryBot.define do
  factory :lot do
    title { Faker::Vehicle.manufacture }
    description { 'Lorem ipsum dolor sit amet.' }
    state { 'good' }
    price { 1000 }
    association :category, factory: :category
    association :user, factory: :user

    # trait 'with_category' do
    #   association :category, factory: :category
    # end
  end
end
