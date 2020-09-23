class Notification < ApplicationRecord
  enum status: %i[unread read]
  enum kind: %i[new-offer
                new-message
                sender-cancel-offer
                recipient-cancel-offer
                suggested-lot-unpublished
                requested-lot-unpublished]

  belongs_to :user
  belongs_to :lot
  belongs_to :my_lot, class_name: 'Lot'
end
