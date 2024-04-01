class Music < ApplicationRecord
  belongs_to :user
  has_many :memories, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  after_update :update_level

  private

  def update_level
    current_level = LevelSetting.where('threshold <= ?', self.experience_point).order(level: :desc).first
    self.update_column(:level, current_level.level) if current_level.present?
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(title artist memories_body) # 検索可能な属性のリストを定義
  end

  def self.ransackable_associations(auth_object = nil)
    %w(memories comments tags users)
  end
end
