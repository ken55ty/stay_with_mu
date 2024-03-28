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
end
