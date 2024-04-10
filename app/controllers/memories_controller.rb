class MemoriesController < ApplicationController
  def edit
    @memory = Memory.find(params[:id])
  end

  def create
    @memory = Memory.new(memory_params)
    if @memory.save
      flash.now[:success] = 'メモリーを追加しました'
    else
      flash.now[:error] = 'メモリーを追加できませんでした'
    end
  end

  def update
    memory = Memory.find(params[:id])
    if memory.update(params.require(:memory).permit(:body, tag_ids: [])) # 汚いので改善したい。
      flash[:success] = 'メモリーを更新しました'
      redirect_to music_path(memory.music)
    else
      flash.now[:erorr] = 'メモリーの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @memory = Memory.find(params[:id])
    @memory.destroy!
    flash.now[:success] = 'メモリーを削除しました'
  end

  private

  def memory_params
    params.require(:memory).permit(:body, tag_ids: []).merge(music_id: params[:music_id])
  end
end
