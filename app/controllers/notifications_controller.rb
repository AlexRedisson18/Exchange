class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order('created_at DESC')
  end

  def read
    current_user.notifications.unread.each(&:read!)
  end
end
