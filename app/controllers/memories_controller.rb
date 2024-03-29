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

  def edit
    @memory = Memory.find(params[:id])
  end

  def update
    memory = Memory.find(params[:id])
    if memory.update(params.require(:memory).permit(:body)) #汚いので改善したい。
      flash[:success] = "メモリーを更新しました"
      redirect_to music_path(memory.music)
    else
      flash.now[:erorr] = "メモリーの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    memory = Memory.find(params[:id])
    memory.destroy!
    flash[:success] = "メモリーを削除しました"
    redirect_to music_path(memory.music)
  end

  private

  def memory_params
    params.require(:memory).permit(:body, tag_ids: []).merge(music_id: params[:music_id])
  end
end
