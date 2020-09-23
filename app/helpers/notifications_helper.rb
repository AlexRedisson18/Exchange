module NotificationsHelper
  def max_count
    current_user.notifications.unread.count > 99 ? '99+' : current_user.notifications.unread.count
  end
end
