class Music < ApplicationRecord
  belongs_to :user
  has_many :memories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_musics, through: :favorites, source: :music
  has_many :playlist_musics, dependent: :destroy
  has_many :playlists, through: :playlist_musics

  validates :title, presence: true
  validates :spotify_track_id, uniqueness: { scope: :user_id }

  enum privacy: { public: 0, private: 1, playlist_only: 2 }, _prefix: true

  scope :visible_to, ->(user) {
    where(privacy: [:public]).or(where(user:, privacy: :private))
  }

  after_update :update_level

  def created_by_user?(user)
    user.musics.exists?(spotify_track_id: self.spotify_track_id)
  end

  def visible_to_user?(user)
    Music.visible_to(user).exists?(id:)
  end

  private

  def update_level
    current_level = LevelSetting.where('threshold <= ?', experience_point).order(level: :desc).first
    update_column(:level, current_level.level) if current_level.present?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title artist] # 検索可能な属性のリストを定義
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[memories comments tags users favorites]
  end

  def self.ransortable_attributes(_auth_object = nil)
    %w[level updated_at memories_count favorites_count comments_count memories_count]
  end
end
