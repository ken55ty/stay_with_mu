module MusicsHelper
  def levelclass(level)
    case level
    when 1..4
      ''
    when 5..9
      'text-cyan-100'
    when 10..19
      'text-cyan-200'
    when 20..29
      'text-sky-300'
    when 30..39
      'text-sky-400'
    when 40..49
      'text-blue-600'
    when 50..69
      'text-yellow-400'
    when 70..99
      'text-orange-500'
    when 100
      'text-red-600'
    else
      ''
    end
  end

  def display_latest_memory(music)
    latest_memory = music.memories.order(created_at: :desc).first
    return unless latest_memory

    concat(content_tag(:div, latest_memory.recommended_topic.topic, class: 'badge badge-warning')) if latest_memory.recommended_topic

    content_tag(:div, class: 'justify-end') do
      latest_memory.tags.each do |tag|
        concat(content_tag(:div, tag.name, class: 'badge badge-primary mr-1'))
      end

      if latest_memory.privacy_private? && current_user != music.user
        concat(content_tag(:p, "非公開のメモリー"))
      elsif latest_memory.body.size >= 16
        concat(content_tag(:p, "#{latest_memory.body.slice(0..16)}..."))
      else
        concat(content_tag(:p, latest_memory.body))
      end
    end
  end

  def display_link_to_music_or_playlist(music)
    current_music = current_user.musics.find_by(spotify_track_id: music.spotify_track_id)
    if current_music.privacy_playlist_only?
      playlist = current_music.playlists.first
      link_to "プレイリストへ", playlist_path(playlist), class: 'btn btn-sm btn-outline btn-success mt-2'
    else
      link_to "作成済みMUへ", music_path(current_music), class: 'btn btn-sm btn-outline btn-warning mt-2'
    end
  end
end
