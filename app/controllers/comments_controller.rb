class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash.now[:success] = 'コメントを追加しました'
    else
      flash.now[:error] = 'コメントを追加できませんでした'
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    flash.now[:success] = 'コメントを削除しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(music_id: params[:music_id])
  end
end
