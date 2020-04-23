class Category < ApplicationRecord
  validates :name, presence: true, null: false

  has_many :lots
end
