module NotificationsHelper
  def generate_notification_message(notification)
    return unless notification

    case notification.notifiable_type
    when 'Comment'
      "#{notification.sender.name}が#{generate_music_link(notification.notifiable.music)}にコメントしました".html_safe
    when 'Favorite'
      "#{notification.sender.name}が#{generate_music_link(notification.notifiable.music)}にいいね！しました".html_safe
    else
      "新着通知がありました"
    end
  end

  def generate_music_link(music)
    link_to music.title, music_path(music), class: "link link-primary", data: { turbo: false }
  end
end
