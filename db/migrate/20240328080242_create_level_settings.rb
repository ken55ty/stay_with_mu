class CreateLevelSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :level_settings do |t|
      t.integer :level
      t.integer :threshold
      t.timestamps
    end
  end
end
