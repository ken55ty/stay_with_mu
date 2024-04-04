class FavoritesController < ApplicationController
  def create
    @music = Music.find(params[:music_id])
    current_user.favorite(@music)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @music = current_user.favorites.find(params[:id]).music
    current_user.unfavorite(@music)
    respond_to do |format|
      format.turbo_stream
    end
  end
end