class Lot < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2, maximum: 24 }, null: false
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  has_many :incoming_offers, class_name: 'Offer', inverse_of: :suggested_lot
  has_many :outgoing_offers, class_name: 'Offer', inverse_of: :requested_lot
end
