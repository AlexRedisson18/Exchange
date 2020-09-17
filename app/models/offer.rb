class Offer < ApplicationRecord
  enum status: %i[pending canceled]

  belongs_to :suggested_lot, class_name: 'Lot', inverse_of: :incoming_offers
  belongs_to :requested_lot, class_name: 'Lot', inverse_of: :outgoing_offers
  has_many :messages, dependent: :destroy

  accepts_nested_attributes_for :messages

  validates :suggested_lot, presence: { message: 'choose suggested lot' }
  validates :requested_lot, presence: { message: 'requested lot not found' }
  validates :suggested_lot, uniqueness: { scope: :requested_lot }
end
