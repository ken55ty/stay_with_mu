class FavoritesController < ApplicationController
  def create
    music = Music.find(params[:music_id])
    current_user.favorite(music)
    redirect_to musics_path
  end

  def destroy
    music = current_user.favorites.find(params[:id]).music
    p music
    current_user.unfavorite(music)
    redirect_to musics_path
  end
end