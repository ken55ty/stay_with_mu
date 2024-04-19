class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :music
  counter_culture :music
  validates :user_id, presence: true, uniqueness: { scope: :music_id }
end
