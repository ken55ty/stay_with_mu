class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :set_norification_object
  include NotificationsHelper

  private

  def not_authenticated
    flash[:warnig] = 'ログインが必要です'
    redirect_to login_path
  end

  def set_norification_object
    if current_user
      @notifications = current_user.received_notifications.unread.limit(10)
    else
      @notifications = []
    end
  end
end
