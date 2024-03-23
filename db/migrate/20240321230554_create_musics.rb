class CreateMusics < ActiveRecord::Migration[7.1]
  def change
    create_table :musics do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :spotify_track_id
      t.string :artist
      t.timestamps
    end
  end
end
