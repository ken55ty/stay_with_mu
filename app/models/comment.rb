class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :music, touch: true
  has_one :notification, as: :notifiable, dependent: :destroy
  counter_culture :music
  validates :body, presence: true, length: { maximum: 65_535 }
end
