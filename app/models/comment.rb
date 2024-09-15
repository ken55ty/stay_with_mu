class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :music, touch: true
  has_one :notification, as: :notifiable, dependent: :destroy
  counter_culture :music
  validates :body, presence: true, length: { maximum: 65_535 }

  def create_notification_comment!(current_user, comment_id)
    # MUのユーザーに通知を送る
    save_notification_comment!(current_user, comment_id, music.user_id)

    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    other_commenters_ids = Comment.select(:user_id).where(music_id:).where.not(user_id: current_user.id).distinct.pluck(:user_id)

    # 各コメントユーザーに対して通知を作成
    other_commenters_ids.each do |commenter_id|
      save_notification_comment!(current_user, comment_id, commenter_id)
    end
  end

  def save_notification_comment!(current_user, _comment_id, recipient_id)
    notification = Notification.new(
      sender_id: current_user.id,
      recipient_id:,
      notifiable: self
    )

    # 自分の投稿に対するコメントの場合は、既読とする
    notification.unread = false if notification.sender_id == notification.recipient_id

    # 通知を保存（バリデーションが成功する場合のみ）
    notification.save if notification.valid?
  end
end
