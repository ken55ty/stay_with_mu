class AddLevelToMusics < ActiveRecord::Migration[7.1]
  def change
    add_column :musics, :experience_point, :integer, default: 0
    add_column :musics, :level, :integer, default: 1
  end
end
