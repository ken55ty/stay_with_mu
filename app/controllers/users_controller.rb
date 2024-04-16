class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]
  before_action :set_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
    @musics = @user.musics.includes(:user, :favorites, memories: :tags).order(updated_at: :desc).page(params[:page])
    @favorite_musics = @user.favorite_musics.includes(:user, :favorites,
                                                      memories: :tags).order(updated_at: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザー登録に成功しました'
      redirect_to root_path
    else
      flash.now[:error] = 'ユーザー登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'プロフィールを更新しました'
      redirect_to @user
    else
      flash.now[:error] = 'プロフィールの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :avatar, :remember_me)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
