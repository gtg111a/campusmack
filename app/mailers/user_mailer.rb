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
 
 def feedback(user)
   @user = user
 end
 
end
