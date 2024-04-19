class AddCommentsCountToMusics < ActiveRecord::Migration[7.1]
  def self.up
    add_column :musics, :comments_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :musics, :comments_count
  end
end
