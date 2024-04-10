class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    flash[:warnig] = 'ログインが必要です'
    redirect_to login_path
  end
end
