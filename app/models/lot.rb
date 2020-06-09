class Lot < ApplicationRecord
  enum status: %i[active archived]
  enum state: %i[excellent good shit]

  has_many :incoming_offers, class_name: 'Offer', inverse_of: :suggested_lot
  has_many :outgoing_offers, class_name: 'Offer', inverse_of: :requested_lot
  belongs_to :category, optional: true
  belongs_to :user

  validates :title, presence: true, length: { minimum: 2 }
  validates :price, numericality: { greater_than_or_equal_to: 1 }
end

# t.string :title, null: false
# t.string :description
# t.string :image, null: false
# t.string :status
# t.string :state
# t.number :price
# t.belongs_to :category
# t.belongs_to :user, null: false
