class UserMailer < ActionMailer::Base
  default :from => "Welcome@campusmack.com"

  def welcome_email(user)
    @user = user
    @url = "campusmack.com"
    mail(:to => @user.email,
      :subject => "Welcome to Campusmack. Now Get Smacking!") do |format|
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
  
  def share_post(post, smacker, title, to, message)
    @post = post
    @smacker = smacker
    @message = message
    @to =  to
    @time = Time.new
    mail(:to => to, :from => 'Campusmack@campusmack.com', :subject => title)
  end

end
