FactoryBot.define do
  factory :music do
    title { 'テスト' }
    artist { 'clearanc' }
    spotify_track_id { '2lyhLZisQc9XXHSREtCa74' }
    association :user
  end
end
