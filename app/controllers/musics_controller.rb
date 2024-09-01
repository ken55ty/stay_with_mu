class MusicsController < ApplicationController
  skip_before_action :require_login, only: %i[index show index_autocomplete]
  before_action :set_music, only: %i[show]
  before_action :check_music_visibility, only: %i[show]

  def index
    @q = Music.ransack(params[:q])
    @q.sorts = ['updated_at desc'] if params[:sorts].blank?
    @musics = @q.result(distinct: true).includes(:user, memories: :tags).privacy_public.page(params[:page])
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
    @musics = Music.where('title ILIKE ? OR artist ILIKE ?', "%#{params[:q]}%", "%#{params[:q]}%").privacy_public.distinct.limit(10)
    render partial: 'musics/autocompletes/index_autocomplete', locals: { musics: @musics, query: params[:q] }
  end

  def publish
    @music = current_user.musics.find(params[:id])
    @music.update_columns(privacy: 0)
    flash.now[:success] = '公開に変更しました'
  end

  def unpublish
    @music = current_user.musics.find(params[:id])
    @music.update_columns(privacy: 1)
    flash.now[:success] = '非公開に変更しました'
  end

  def convert_to_public
    @music = current_user.musics.find(params[:id])
    if @music.update(privacy: :public)
      flash[:success] = 'MUを作成しました！'
      redirect_to @music
    else
      render 'playlists#show(@music)'
    end
  end

  private

  def music_params
    params.require(:music).permit(:artist, :spotify_track_id, :title)
  end

  def set_music
    @music = Music.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'MUは存在しないか、非公開です'
    redirect_to musics_path
  end

  def check_music_visibility
    return if @music.privacy_public?

    unless logged_in? && current_user.own?(@music)
      flash[:error] = 'MUは存在しないか、非公開です'
      redirect_to musics_path
    end
  end
end
