class Message < ApplicationRecord
  belongs_to :offer
  belongs_to :user

  validates :body, presence: { message: 'fill the field!' }
end
