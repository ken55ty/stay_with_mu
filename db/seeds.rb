tag_mappings = {
  1 => '思い出',
  2 => '推しポイント',
  3 => '好きな歌詞',
  4 => 'ライブ',
  5 => '推し活',
  6 => '主題歌',
  7 => 'カラオケ',
  8 => '考察',
  9 => '演奏'
}

tag_mappings.each do |id, name|
  Tag.find_or_create_by!(id: id, name: name)
end

LevelSetting.find_or_create_by!(level: 1, threshold: 0)
prev_threshold = 0

# 各レベルの閾値を設定
(2..100).each do |level|
  # 次のレベルに必要なexpを1ずつ上げる
  threshold = prev_threshold + level + 3
  LevelSetting.find_or_create_by!(level: level, threshold: threshold)
  prev_threshold = threshold
end