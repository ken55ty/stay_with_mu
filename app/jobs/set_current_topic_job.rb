class SetCurrentTopicJob < ApplicationJob
  queue_as :default

  def perform
    ActiveRecord::Base.transaction do
      # 前回のトピックを無効化
      previous_topic = RecommendedTopic.find_by(current: true)
      previous_topic&.update(current: false)

      # 前回のトピックを除外してランダムにトピックを選択
      todays_topic = if previous_topic
                       RecommendedTopic.where.not(id: previous_topic.id).order(Arel.sql('RANDOM()')).first
                     else
                       RecommendedTopic.order(Arel.sql('RANDOM()')).first
                     end

      # 新しいトピックを有効化
      todays_topic&.update(current: true)
    end
  end
end
