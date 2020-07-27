class Lot < ApplicationRecord
  enum status: %i[published unpublished]
  enum state: %i[excellent good shit]

  mount_uploaders :images, ImageUploader

  has_many :incoming_offers, class_name: 'Offer', inverse_of: :suggested_lot
  has_many :outgoing_offers, class_name: 'Offer', inverse_of: :requested_lot
  has_and_belongs_to_many :interesting_categories, class_name: 'Category', inverse_of: :interested_lot
  belongs_to :category
  belongs_to :user

  validates :title, presence: true
  validates :title, length: { minimum: 2 },
                    if: :some_title?
  validates :price, presence: { message: 'specify a price, or choose one or more interesting categories' },
                    if: :no_categories?
  validates :price, numericality: { greater_than_or_equal_to: 1 }, if: :some_price?
  validates :interesting_categories, presence: { message: 'choose one or more category, or specify a price' },
                                     if: :no_price?

  def no_price?
    price.nil?
  end

  def no_categories?
    interesting_categories.empty?
  end

  def some_price?
    price.present?
  end

  def some_title?
    title.present?
  end
end
