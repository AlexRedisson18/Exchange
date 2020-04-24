class Category < ApplicationRecord
  has_many :lots

  validates :name, presence: true, uniqueness: true
end
