class MusicsController < ApplicationController
  skip_before_action :require_login, only: %i[index show index_autocomplete]

  def index
    @q = Music.ransack(params[:q])
    @q.sorts = ['updated_at desc'] if params[:sorts].blank?
    @musics = @q.result(distinct: true).includes(:user, memories: :tags).page(params[:page])
  end

  def search
    if params[:q].present?
      search_results = RSpotify::Track.search(params[:q])
      @musics = search_results.first(20).map do |track|
        Music.new(
          spotify_track_id: track.id,
          title: track.name,
          artist: track.artists.first.name
        )
      end
    else
      @musics = [] # 検索クエリがない場合は空の結果を返す
    end

    respond_to do |format|
      format.js { render partial: 'musics/autocompletes/new_autocomplete', locals: { musics: @musics } }
      format.html { render :new }
    end
  end

  def show
    @music = Music.find(params[:id])
    @memory = Memory.new
    @memories = @music.memories.includes(:tags).order(created_at: :desc)
    @comment = Comment.new
    @comments = @music.comments.includes(:user).order(created_at: :asc)
  end

  # GET /musics/new
  def new
    @music = Music.new
  end

  # POST /musics or /musics.json
  def create
    @music = current_user.musics.build(music_params)
    if @music.save
      flash[:success] = 'MUを作成しました！'
      redirect_to @music
    else
      flash.now[:error] = 'MUの作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    music = current_user.musics.find(params[:id])
    music.destroy!
    flash[:success] = 'MUを削除しました'
    redirect_to musics_path, status: :see_other
  end

  def index_autocomplete
    @musics = Music.where('title ILIKE ? OR artist ILIKE ?', "%#{params[:q]}%", "%#{params[:q]}%").distinct.limit(10)
    render partial: 'musics/autocompletes/index_autocomplete', locals: { musics: @musics, query: params[:q] }
  end

  private

  def music_params
    params.permit(:artist, :spotify_track_id, :title)
  end
end
