class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def method_missing(provider)
    return if User.omniauth_providers.index(provider).nil?
    omniauth = env["omniauth.auth"]

    if current_user
      current_user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
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
      # Create username from the full name
      #h[:username] ||= [h[:first_name], h[:last_name]].join('_').removeaccents.downcase
      h[:provider] = Authentication.create!(:provider => omniauth['provider'], :uid => omniauth['uid']).id
      session.merge!(h)
      if User.find_by_email(h[:email])
        flash[:notice] = "A user with #{user.email} already exists."
      else
        flash[:notice] = 'Successful Authentication. Please fill out the remaining required fields below to complete the registration.'
      end
      redirect_to new_user_registration_url
      return
    end
  end

end