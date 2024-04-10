class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    flash[:success] = 'パスワードリセットのメールを送信しました'
    redirect_to login_path
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    @user.password = params[:user][:password]
    if @user.valid?(:reset_password) && @user.change_password(params[:user][:password])
      flash[:success] = 'パスワードがリセットされました'
      redirect_to login_path
    else
      flash.now[:error] = 'パスワードリセットに失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end
end
