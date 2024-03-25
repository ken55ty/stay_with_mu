class CreateMemories < ActiveRecord::Migration[7.1]
  def change
    create_table :memories do |t|
      t.references :music, null: false, foreign_key: true
      t.text :body, null: false
      t.timestamps
    end
  end
end
