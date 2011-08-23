class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def method_missing(provider)
    return if User.omniauth_providers.index(provider).nil?
    omniauth = env["omniauth.auth"]

    if current_user
      flash[:notice] = "Authentication successful"
      redirect_to edit_user_registration_path
    else
      authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).limit(1).first
      if authentication
        if authentication.user
          session[:provider] = authentication.id
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
          sign_in_and_redirect(:user, authentication.user)
          return
        end
      end

      h = {}
      if (omniauth['provider'] == 'facebook')
        h[:email] = omniauth['extra']['user_hash']['email']
        h[:first_name], h[:last_name] = omniauth['extra']['user_hash']['name'].split
      elsif (omniauth['provider'] == 'google_apps')
        h[:email] = omniauth['user_info']['email']
        h[:first_name] = omniauth['user_info']['first_name']
        h[:last_name] = omniauth['user_info']['last_name']
      end
      user = User.where(:email => h[:email]).first
      # Create username from the full name
      #h[:username] ||= [h[:first_name], h[:last_name]].join('_').removeaccents.downcase
      auth = Authentication.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      h[:provider] = auth.id
      session.merge!(h)
      if user
        if user.authentications.include?(auth)
          flash[:notice] = "You already added this service"
        else
          user.authentications << auth
          flash[:notice] = "Added #{omniauth['provider']} to your existing account."
        end
        sign_in(user)
        redirect_to authentications_path
        return
      end
      flash[:notice] = 'Successful Authentication. Please fill out the remaining required fields below to complete the registration.'
      redirect_to new_user_registration_url
    end
  end

end