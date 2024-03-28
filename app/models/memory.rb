class Memory < ApplicationRecord
  belongs_to :music, touch: true
  has_many :memory_tags, dependent: :destroy
  has_many :tags, through: :memory_tags

  validates :body, presence: true, length: { maximum: 65_535 }
  validate :validate_tag_count

  private

  def validate_tag_count
    max_tags = 3
    if tag_ids.count > max_tags
      errors.add(:base, "選択できるタグは#{max_tags}個までです")
    end
  end
end
