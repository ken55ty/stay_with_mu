class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create destroy]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path, notice: 'Login successful'
    else
      flash.now[:alert] = 'Login failed'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_url, status: :see_other, notice: 'ログアウトしました。'
  end
end
