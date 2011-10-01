# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Campusmack::Application.initialize!

ActionMailer::Base.default_content_type = "text/html"

ActionMailer::Base.smtp_settings = {
  :address  => "smtp.mailgun.org",
  :port  => 25,
  :user_name  => "postmaster@campusmack.mailgun.org",
  :password  => "96w595chb487",
  :authentication  => :login
}