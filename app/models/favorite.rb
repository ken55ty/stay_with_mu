class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :music
  validates :user_id, presence: true, uniqueness: { scope: :music_id }
end
