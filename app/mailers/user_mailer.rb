class UserMailer < ActionMailer::Base
  default :from => "Welcome@comapusmack.com"

def welcome_email(user)
@user = user
@url = "campusmack.heroku.com"
mail(:to => @user.email,
      :subject => "Welcome to Campus Smack. Now Get Smacking!")
 end
end
