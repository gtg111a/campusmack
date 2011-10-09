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
  
  def share_post(post, poster,title, message, inc_count)
    @post = post
    @message = message
    recevier=@message.to.to_s
    if poster.blank?
      subject = "#{post.title} is shared through #{SITE_NAME} as #{@post.type} "
    else
      subject = "#{post.title} is shared by <#{poster.username}> as #{@post.type} through #{SITE_NAME}"
    end
    mail(:to => @message.to,:from => 'Campusmack.com', :subject => title)
    if inc_count == 1
      poster.increment_smack_send
      smack_send = SmackSend.new
      smack_send.user_id = poster.id
      smack_send.post_id = @post.id
      message_array = recevier.split(",") rescue @mesage.to
      smack_send.send_number = message_array.length
      smack_send.save  
    end
  end
  
end
