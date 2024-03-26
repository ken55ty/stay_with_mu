class CreateMemoryTags < ActiveRecord::Migration[7.1]
  def change
    create_table :memory_tags do |t|
      t.references :memory, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end
  end
end
