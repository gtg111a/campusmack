class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_authorization_check
  skip_before_filter :verify_authenticity_token

  def method_missing(provider)
    return if User.omniauth_providers.index(provider).nil?
    omniauth = env["omniauth.auth"]
    # user already logged in, assign the new provider to him
    if current_user
      current_user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      flash[:notice] = "Added #{omniauth['provider']} to your existing account."
      redirect_to edit_user_registration_path
      return
    end

    # Sign in/sign up with an external service
    authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
    authentication ||= Authentication.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
    # Sign in
    if authentication.user
      session[:provider] = authentication.id
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
      sign_in_and_redirect(:user, authentication.user)
      return
    end

    # Collecting data from providers to fill the signup form's fields
    h = {}
    if (omniauth['provider'] == 'facebook')
      h[:email] = omniauth['extra']['user_hash']['email']
      h[:first_name], h[:last_name] = omniauth['extra']['user_hash']['name'].split
    elsif (omniauth['provider'] == 'google_apps')
      h[:email] = omniauth['user_info']['email']
      h[:first_name] = omniauth['user_info']['first_name']
      h[:last_name] = omniauth['user_info']['last_name']
    elsif (omniauth['provider'] == 'twitter')
      h[:username] = omniauth['user_info']['nickname']
      h[:first_name], h[:last_name] = omniauth['user_info']['name'].split
    end
    # Create username from the full name
    #h[:username] ||= [h[:first_name], h[:last_name]].join('_').removeaccents.downcase
    h[:provider] = authentication.id
    session.merge!(h)
    flash[:notice] = 'Successful Authentication. Please fill out the remaining required fields below to complete the registration.'
    redirect_to new_user_registration_url
  end

end
