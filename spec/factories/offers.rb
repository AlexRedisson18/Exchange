FactoryBot.define do
  factory :offer do
    association :requested_lot, factory: :lot
    association :suggested_lot, factory: :lot
  end
end
