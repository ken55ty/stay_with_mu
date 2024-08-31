class RemoveOnlyForPlaylistFromMusics < ActiveRecord::Migration[7.1]
  def change
    remove_column :musics, :only_for_playlist, :boolean
  end
end
