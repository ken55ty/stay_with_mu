class Memory < ApplicationRecord
  belongs_to :music, touch: true
  belongs_to :recommended_topic, optional: true
  has_many :memory_tags, dependent: :destroy
  has_many :tags, through: :memory_tags
  counter_culture :music

  validates :body, presence: true, length: { maximum: 65_535 }
  validate :validate_tag_count

  enum privacy: { public: 0, private: 1 }, _prefix: true

  private

  def validate_tag_count
    max_tags = 3
    return unless tag_ids.count > max_tags

    errors.add(:base, "選択できるタグは#{max_tags}個までです")
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[body created_at id id_value music_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[music]
  end

  def self.ransortable_attributes(_auth_object = nil)
    %w[memories_count]
  end
end
