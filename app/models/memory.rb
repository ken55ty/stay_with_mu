class Memory < ApplicationRecord
  belongs_to :music, touch: true
  has_many :memory_tags, dependent: :destroy
  has_many :tags, through: :memory_tags

  validates :body, presence: true, length: { maximum: 65_535 }
end
