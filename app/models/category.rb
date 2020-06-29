class Category < ApplicationRecord
  has_many :lots
  has_and_belongs_to_many :interested_lots, class_name: 'Lot', inverse_of: :interesting_category
  validates :name, presence: true, uniqueness: true
end
