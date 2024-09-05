class PlaylistsController < ApplicationController
  skip_before_action :require_login, only: %i[show]
  def show
    @playlist = Playlist.find(params[:id])
  end

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

  def create
    @playlist = current_user.playlists.build(playlist_params)

    if session[:current_playlist_musics].present?
      session[:current_playlist_musics].each do |music_params|
        music = Music.find_or_initialize_by(spotify_track_id: music_params["spotify_track_id"], user_id: current_user.id)
        if music.new_record?
          music.assign_attributes(music_params.slice("title", "artist", "experience_point", "level", "favorites_count", "comments_count", "memories_count"))
          music.privacy_playlist_only!
          music.save!
        end
        @playlist.musics << music
      end
    end

    if @playlist.save
      session.delete(:current_playlist_musics)
      @playlist.musics.each(&:update_music_exp)
      flash[:success] = 'プレイリストを作成しました'
      redirect_to @playlist
    else
      flash.now[:error] = "プレイリストの作成に失敗しました"
      render :new
    end
  end

  def add_music_to_playlist
    @music = current_user.musics.build(music_params)
    session[:current_playlist_musics] ||= []
    session[:current_playlist_musics].each do |music_params|
      p music_params["spotify_track_id"]
    end
    session[:current_playlist_musics] << @music unless session[:current_playlist_musics].include?(@music.spotify_track_id)
  end

  def remove_music_from_playlist
    session[:current_playlist_musics].reject! { |music| music["spotify_track_id"] == params[:id] }

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("playlist-music-#{params[:id]}")
      end
    end
  end

  private

  def music_params
    params.require(:music).permit(:artist, :spotify_track_id, :title, :privacy)
  end

  def playlist_params
    params.require(:playlist).permit(:title, :body)
  end
end
