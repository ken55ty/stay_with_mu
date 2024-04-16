class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create destroy]

  def new; end

  def create
    @user = login(params[:email], params[:password], params[:remember_me])

    if @user
      flash[:success] = 'ログインしました'
      redirect_to musics_path
    else
      flash.now[:error] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    remember_me!
    forget_me!
    logout
    flash[:success] = 'ログアウトしました'
    redirect_to root_url, status: :see_other
  end
end
