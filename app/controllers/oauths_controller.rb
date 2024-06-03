class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    # 指定されたプロバイダの認証ページにユーザーをリダイレクトさせる
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    notice_message = "#{provider.titleize}アカウントでログインしました"

    # ログインを試みる
    @user = login_from(provider)
    after_login_path = musics_path
    unless @user
      # プロバイダ情報の取得
      sorcery_fetch_user_hash(provider)
      # 既存のユーザーを探す
      @user = User.find_by(email: @user_hash[:user_info]['email'])

      if @user
        # 既存のユーザーにプロバイダ情報を追加
        @user.add_provider_to_user(provider, @user_hash[:uid].to_s)
        notice_message = "#{provider.titleize}アカウントの情報を追加してログインしました！"
      else
        # 新しいユーザーを作成
        @user = create_from(provider)
        notice_message = "#{provider.titleize}アカウントでログインしました！ユーザー名を設定してください！"
        after_login_path = user_path(@user)
      end

      reset_session
      auto_login(@user)
    end

    flash[:success] = notice_message
    redirect_to after_login_path
  rescue StandardError
    flash.now[:error] = "#{provider.titleize}アカウントでのログインに失敗しました"
    redirect_to login_path
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
