class AddOnlyForPlaylistToMusics < ActiveRecord::Migration[7.1]
  def change
    add_column :musics, :only_for_playlist, :boolean, default: false, null: false
  end
end
