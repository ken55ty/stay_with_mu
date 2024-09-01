class PlaylistMusic < ApplicationRecord
  belongs_to :music
  belongs_to :playlist

  validates :music_id, uniqueness: { scope: :playlist_id }
end
