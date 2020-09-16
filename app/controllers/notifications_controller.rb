class NotificationsController < ApplicationController
  def index
    @user = current_user
    @notifications = @user.notifications.order('created_at DESC')
  end

  def read
    @user = current_user
    @user.notifications.each(&:readed!)
  end
end
