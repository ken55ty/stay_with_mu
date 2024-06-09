class ChangeTopicToRecommendedTopicInMemories < ActiveRecord::Migration[7.1]
  def change
    remove_column :memories, :topic, :boolean
    add_reference :memories, :recommended_topic, foreign_key: true, null: true
  end
end
