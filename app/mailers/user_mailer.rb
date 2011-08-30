class UserMailer < ActionMailer::Base
  default :from => "Welcome@campusmack.com"

  def welcome_email(user)
    @user = user
    @url = "campusmack.heroku.com"
    mail(:to => @user.email,
         :subject => "Welcome to Campus Smack. Now Get Smacking!") do |format|
      format.html
      #format.text
    end
  end

  def support_notification(support)
    @support = support
    mail(:to => "feedback@campusmack.mailgun.org",
         :from => support.email,
         :subject => "New #{support.support_type}")
  end

end
