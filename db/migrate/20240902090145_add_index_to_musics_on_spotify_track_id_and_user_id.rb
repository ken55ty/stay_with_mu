class AddIndexToMusicsOnSpotifyTrackIdAndUserId < ActiveRecord::Migration[7.1]
  def change
    add_index :musics, [:spotify_track_id, :user_id], unique: true
  end
end
