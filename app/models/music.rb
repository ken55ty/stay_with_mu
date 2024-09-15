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

  scope :visible_to, lambda { |user|
    where(privacy: [:public]).or(where(user:, privacy: :private))
  }

  ADDITIONAL_EXP_PER_PLAYLIST = 100

  def update_music_exp
    return if frozen?

    total_exp = calculate_memory_exp + calculate_playlist_exp
    update_column(:experience_point, total_exp)
    update_level
  end

  def created_by_user?(user)
    user.musics.exists?(spotify_track_id:)
  end

  def visible_to_user?(user)
    Music.visible_to(user).exists?(id:)
  end

  private

  def calculate_memory_exp
    memories.sum { |memory| memory.body.length }
  end

  def calculate_playlist_exp
    playlists.sum { |playlist| playlist.body.length } + (playlists.count * ADDITIONAL_EXP_PER_PLAYLIST)
  end

  def update_level
    current_level = LevelSetting.where('threshold <= ?', experience_point).order(level: :desc).first
    update_column(:level, current_level.level) if current_level
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
