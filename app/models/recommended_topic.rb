class RecommendedTopic < ApplicationRecord
  has_many :memories
  scope :current, -> { find_by(current: true) }
end
