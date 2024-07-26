class Music < ApplicationRecord
  belongs_to :user
  has_many :memories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_musics, through: :favorites, source: :music

  validates :title, presence: true

  enum privacy: { public: 0, private: 1 }, _prefix: true

  scope :visible_to, ->(user) {
    where(privacy: [:public]).or(where(user:, privacy: :private))
  }

  after_update :update_level

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
