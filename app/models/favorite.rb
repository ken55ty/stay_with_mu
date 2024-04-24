class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :music
  has_one :notification, as: :notifiable, dependent: :destroy
  counter_culture :music
  validates :user_id, presence: true, uniqueness: { scope: :music_id }

  after_create_commit :create_favorite_notification

  private

  def create_favorite_notification
    return if self.user_id == self.music.user_id

    Notification.create(
      sender_id: self.user_id,
      recipient_id: self.music.user_id,
      notifiable: self
    )
  end
end
