require 'mailgun'

module MailHelper
  
  Mailgun::init("key-afy6amxoo2fnj$u@mc")
  
  def send_welcome
    sender   = "Welcome@campusmack.mailgun.org"
    receiver = "michael.bivone@gmail.com"
    raw_mime =
    "<!DOCTYPE html>
    <html>
    <head>
      <meta content=" + "text/html; charset=UTF-8" + "http-equiv="+"Content-Type"+" />
    </head>
    <body>
      <h1>Welcome to campusmack.com, #{current_user.first_name}</h1>
      <p>
        You have successfully signed up to campusmack.com,
        your username is: #{current_user.name}.<br/>
      </p>
      <p>
        To login to the site, just follow this link: www.campusmack.com.
      </p>
      <p>Thanks for joining and have a great day!</p>
    </body>"
    MailgunMessage::send_raw(sender, receiver, raw_mime.html_safe)

    puts "Messages sent"
  end
  
  def welcome_email
  @url = "campusmack.heroku.com"
  mail(:to =>current_user.email,
        :subject => "Welcome to Campus Smack. Now Get Smacking!")
   end
  
end
