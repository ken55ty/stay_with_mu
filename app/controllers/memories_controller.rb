class MemoriesController < ApplicationController
  def create
    memory = Memory.new(memory_params)
    if memory.save
      flash[:success] = "メモリーを追加しました"
      redirect_to music_path(memory.music), status: :see_other
    else
      flash.now[:erorr] = "メモリーの追加に失敗しました"
      redirect_to music_path(memory.music), status: :see_other
    end
  end

  private

  def memory_params
    params.require(:memory).permit(:body).merge(music_id: params[:music_id])
  end
end
