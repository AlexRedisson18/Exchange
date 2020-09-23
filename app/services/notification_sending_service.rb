class NotificationSendingService
  def initialize(kind, lot, lot_target)
    @kind = kind
    @lot = lot
    @lot_target = lot_target
  end

  def call
    @lot_target.user.notifications.create(kind: @kind,
                                          lot_id: @lot.id,
                                          my_lot_id: @lot_target.id)
  end
end
