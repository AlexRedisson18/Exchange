FactoryBot.define do
  factory :notification do
    status { 'unread' }
    kind { 'new-offer' }
    association :my_lot, factory: :lot
    lot
    user
  end
end
