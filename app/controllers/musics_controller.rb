class MusicsController < ApplicationController
  skip_before_action :require_login
  def search
    if params[:search].present?
      search_results = RSpotify::Track.search(params[:search])
      @musics = search_results.first(20).map do |track|
        {
          id: track.id,
          title: track.name,
          artist: track.artists.first.name,
        }
      end
    else
      @musics = []  # 検索クエリがない場合は空の結果を返す
    end

    render :new
  end


  # GET /musics/new
  def new
    @music = Music.new
  end

  # POST /musics or /musics.json
  def create
    @music = current_user.musics.build(music_params)
      if @music.save
        flash[:success] = "MUを作成しました！"
        redirect_to root_path
      else
        flash.now[:error] = "MUの作成に失敗しました"
        render :new, status: :unprocessable_entity
      end
  end

  private

  def music_params
    params.permit(:artist, :spotify_track_id, :title)
  end
end
