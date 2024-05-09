tag_mappings = {
  1 => '思い出',
  2 => '推しポイント',
  3 => '好きな歌詞',
  4 => 'ライブ',
  5 => '推し活',
  6 => '主題歌',
  7 => 'カラオケ',
  8 => '考察',
  9 => '演奏',
  10 => '豆知識',
  11 => 'MV',
  12 => 'ライブ映像'
}

tag_mappings.each do |id, name|
  Tag.find_or_create_by!(id:, name:)
end

LevelSetting.find_or_create_by!(level: 1, threshold: 0)
prev_threshold = 0

# 各レベルの閾値を設定
(2..100).each do |level|
  # 次のレベルに必要なexpを1ずつ上げる
  #レベル1からレベル2までの閾値を5にするために2+3の3を足している
  threshold = prev_threshold + level + 3
  LevelSetting.find_or_create_by!(level:, threshold:)
  prev_threshold = threshold
end

topics = {
  1 => '一番最初にハマったアーティストの話',
  2 => 'ランニングの時に聴きたい曲',
  3 => '夜に聴きたくなる曲',
  4 => '初めて自分で買ったCD',
  5 => '印象に残っているライブ'
}

topics.each do |id, topic|
  RecommendedTopic.find_or_create_by!(id:, topic:)
end