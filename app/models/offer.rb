class Offer < ApplicationRecord
  enum status: %i[pendind rejected confirmed]

  belongs_to :suggested_lot, class_name: 'Lot', inverse_of: :incoming_offers
  belongs_to :requested_lot, class_name: 'Lot', inverse_of: :outgoing_offers

  validates :suggested_lot, :requested_lot, presence: true
  validates :suggested_lot, uniqueness: { scope: :requested_lot }
end
