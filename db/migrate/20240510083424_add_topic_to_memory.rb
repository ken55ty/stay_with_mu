class AddTopicToMemory < ActiveRecord::Migration[7.1]
  def change
    add_column :memories, :topic, :boolean, default: false
  end
end
