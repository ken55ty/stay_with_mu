module PlaylistsHelper
  def shrunk_title_for_link(playlist)
    if playlist.title.length >= 16
      "#{playlist.title.slice(0..16)}..."
    else
      playlist.title
    end
  end

  def shrunk_title_for_index(playlist)
    if playlist.title.length >= 30
      "#{playlist.title.slice(0..30)}..."
    else
      playlist.title
    end
  end
end