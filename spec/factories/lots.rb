FactoryBot.define do
  factory :lot do
    title { Faker::Vehicle.manufacture }
    description { 'Lorem ipsum dolor sit amet.' }
    state { 'good' }
    price { 1000 }
    images { [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image.jpg'), 'image/jpeg')] }
    category
    user
    trait :with_user do
      user
    end
  end
end
