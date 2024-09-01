class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  authenticates_with_sorcery!
  has_many :musics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_musics, through: :favorites, source: :music
  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_notifications, class_name: 'Notification', foreign_key: 'recipient_id', dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :playlists, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :profile, length: { maximum: 255 }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  validates :password, presence: true, on: :reset_password
  validates :password_confirmation, presence: true, on: :reset_password

  def own?(object)
    id == object&.user_id
  end

  def favorite(music)
    favorite_musics << music
  end

  def unfavorite(music)
    favorite_musics.destroy(music)
  end

  def favorite?(music)
    favorite_musics.include?(music)
  end
end
