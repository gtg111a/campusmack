class UserMailer < ActionMailer::Base
  default :from => 'Campusmack <donotreply@campusmack.com>'

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

  def share_post(post, smacker, title, to, message, send_as_smack)
    @post = post
    @smacker = smacker
    @message = message
    @to = to
    @time = Time.new
    @send_as_smack = send_as_smack
    mail(:to => to, :subject => title)
  end

end
