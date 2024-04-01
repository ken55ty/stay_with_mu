class Music < ApplicationRecord
  belongs_to :user
  has_many :memories, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  after_update :update_level

  ransacker :memories_count do
    query = <<-SQL
    (SELECT
       COUNT(memories.music_id)
     FROM
       memories
     WHERE
       memories.music_id = music.id
     GROUP BY
       memories.music_id)
  SQL
  Arel.sql(query)
  end

  private

  def update_level
    current_level = LevelSetting.where('threshold <= ?', self.experience_point).order(level: :desc).first
    self.update_column(:level, current_level.level) if current_level.present?
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(title artist) # 検索可能な属性のリストを定義
  end

  def self.ransackable_associations(auth_object = nil)
    %w(memories comments tags users)
  end

  def self.ransortable_attributes(auth_object = nil)
    %w(level updated_at memories_count)
  end
end
