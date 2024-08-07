class CommentsController < ApplicationController
  def edit
    @comment = Comment.find(params[:id])
    unless current_user == @comment.user
      flash[:error] = '編集権限がありません'
      redirect_to root_path
    end
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      @comment.create_notification_comment!(current_user, @comment.id)
      flash.now[:success] = 'コメントを追加しました'
    else
      flash.now[:error] = 'コメントを追加できませんでした'
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(params.require(:comment).permit(:body))
      flash[:success] = 'コメントを更新しました'
      redirect_to music_path(@comment.music)
    else
      flash.now[:error] = 'コメントの更新に失敗しました'
      render :edit, status: :unprocessable_entity
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
