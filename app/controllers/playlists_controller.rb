class PlaylistsController < ApplicationController

  def new
    session[:current_playlist_musics] ||= []
    session[:current_playlist_musics].clear
    @music = Music.new
    @musics = []
    @playlist = Playlist.new
  end

  def search
    if params[:q].present?
      search_results = RSpotify::Track.search(params[:q])
      @musics = search_results.first(8).map do |track|
        Music.new(
          spotify_track_id: track.id,
          title: track.name,
          artist: track.artists.first.name
        )
      end
    else
      @musics = []
    end

    respond_to do |format|
      format.js { render partial: 'musics/autocompletes/new_autocomplete', locals: { musics: @musics } }
      format.html { render :new }
    end
  end
end
