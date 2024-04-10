class UserMailer < ApplicationMailer
  default from: 'baskent.5.23@gmail.com'

  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email,
         subject: 'パスワード再設定用URLのお知らせ')
  end
end
