class AddRowOrderToPlaylistMusics < ActiveRecord::Migration[7.1]
  def change
    add_column :playlist_musics, :row_order, :integer
    PlaylistMusic.update_all('row_order = EXTRACT(EPOCH FROM created_at)')
  end
end
