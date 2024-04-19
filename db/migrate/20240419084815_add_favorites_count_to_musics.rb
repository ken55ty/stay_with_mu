class AddFavoritesCountToMusics < ActiveRecord::Migration[7.1]
  def self.up
    add_column :musics, :favorites_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :musics, :favorites_count
  end
end
