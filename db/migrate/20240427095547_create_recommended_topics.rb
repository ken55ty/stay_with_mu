class CreateRecommendedTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :recommended_topics do |t|
      t.string :topic
      t.boolean :current, default: false

      t.timestamps
    end
  end
end
