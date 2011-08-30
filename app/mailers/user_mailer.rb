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
 
 def support_notification(sender)
     @sender = sender
     mail(:to => "feedback@campusmack.mailgun.org",
          :from => sender.email,
          :subject => "New #{sender.support_type}") do |format|
          format.html
        end
  end
 
end
