class Memory < ApplicationRecord
  belongs_to :music, touch: true

  validates :body, presence: true, length: { maximum: 65_535 }
end
