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
  Tag.create!(id: id, name: name)
end