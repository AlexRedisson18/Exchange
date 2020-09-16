class Notification < ApplicationRecord
  enum status: %i[unreaded readed]
  enum kind: %i[new-offer
                new-message
                sender-cancel-offer
                recipient-cancel-offer
                suggested-lot-unpublished
                requested-lot-unpublished]

  belongs_to :user
  belongs_to :lot, optional: true
  belongs_to :my_lot, class_name: 'Lot', optional: true
end
