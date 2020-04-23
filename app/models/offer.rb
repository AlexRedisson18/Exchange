class Offer < ApplicationRecord
  validates :suggested_lot, presence: true, null: false
  validates :requested_lot, presence: true, null: false

  belongs_to :suggested_lot, class_name: 'Lot', inverse_of: :incoming_offers
  belongs_to :requested_lot, class_name: 'Lot', inverse_of: :outgoing_offers
end
