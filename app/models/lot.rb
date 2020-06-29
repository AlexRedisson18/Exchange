class Lot < ApplicationRecord
  enum status: %i[active archived]
  enum state: %i[excellent good shit]

  has_many :incoming_offers, class_name: 'Offer', inverse_of: :suggested_lot
  has_many :outgoing_offers, class_name: 'Offer', inverse_of: :requested_lot
  has_and_belongs_to_many :interesting_categories, class_name: 'Category', inverse_of: :interested_lot
  belongs_to :category
  belongs_to :user

  validates :title, presence: true, length: { minimum: 2 }
  validates :category, presence: true

  with_options if: :no_categories? do
    validates :price, numericality: { greater_than_or_equal_to: 1 }
    validates :price, presence: { message: 'specify a price, or choose one or more interesting categories' }
  end

  with_options if: :no_price? do
    validates :interesting_categories, presence: { message: 'choose one or more category, or specify a price' }
  end

  def no_price?
    price.nil?
  end

  def no_categories?
    interesting_categories.empty?
  end
end
