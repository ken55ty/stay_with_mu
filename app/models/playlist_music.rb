class PlaylistMusic < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: :playlist_id

  belongs_to :music
  belongs_to :playlist

  validates :music_id, uniqueness: { scope: :playlist_id }
end
