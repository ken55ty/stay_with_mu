class NotificationsController < ApplicationController
  def update
    @notification = current_user.received_notifications.find(params[:id])
    @notification.update(unread: false)
    if @notification
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
              turbo_stream.remove(@notification),
              turbo_stream.replace('notification_count', partial: 'notifications/notification_count', locals: { notifications: current_user.notifications.unread })
          ]
        end
        format.html
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
              turbo_stream.replace('notifications', '')
          ]
        end
      end
    end
  end

  def mark_all_as_read
    @notifications = current_user.received_notifications.unread
    @notifications.destroy_all
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove('notifications'),
          turbo_stream.replace('notification_count', partial: 'notifications/notification_count', locals: { notifications: current_user.notifications.unread })
        ]
      end
      format.html
    end
  end
end