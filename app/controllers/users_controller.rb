class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "ユーザー登録に成功しました"
      redirect_to root_path
    else
      flash.now[:error] = "ユーザー登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user =User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      flash.now[:error] = "プロフィールの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile)
  end
end
