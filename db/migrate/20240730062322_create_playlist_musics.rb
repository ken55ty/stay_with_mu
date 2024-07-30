class CreatePlaylistMusics < ActiveRecord::Migration[7.1]
  def change
    create_table :playlist_musics do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :music, null: false, foreign_key: true
      t.timestamps
    end
    add_index :playlist_musics, %i[playlist_id music_id], unique: true
  end
end
