class SetCurrentTopicJob < ApplicationJob
  queue_as :default

  def perform
    ActiveRecord::Base.transaction do
      RecommendedTopic.where(current: true).update_all(current: false)

      todays_topic = RecommendedTopic.order(Arel.sql('RANDOM()')).first
      todays_topic.update(current: true)
    end
  end
end