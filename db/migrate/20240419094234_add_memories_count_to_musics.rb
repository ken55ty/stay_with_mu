class AddMemoriesCountToMusics < ActiveRecord::Migration[7.1]
  def self.up
    add_column :musics, :memories_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :musics, :memories_count
  end
end
