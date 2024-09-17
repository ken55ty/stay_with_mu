class RecommendedTopic < ApplicationRecord
  has_many :memories, dependent: :destroy
  scope :current, -> { find_by(current: true) }
end
