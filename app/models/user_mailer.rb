class UserMailer < ActionMailer::Base

  def signup(user)
    recipients    user.email
    from          "no-reply@simpleblog.cn"
    subject       "Здравствуйте!"
    body          :user => user
  end

end
