class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      flash[:success] = "コメントを追加しました"
      redirect_to music_path(comment.music)
    else
      flash[:error] = "コメントを追加できませんでした"
      redirect_to music_path(comment.music)
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy!
    flash[:success] = "コメントを削除しました"
    redirect_to music_path(comment.music), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(music_id: params[:music_id])
  end
end
