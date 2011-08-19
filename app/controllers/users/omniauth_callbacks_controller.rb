class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def method_missing(provider)
    return if User.omniauth_providers.index(provider).nil?
    omniauth = env["omniauth.auth"]

    if current_user
      current_user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      flash[:notice] = "Authentication successful"
      redirect_to edit_user_registration_path
    else
      authentication = Authentication.where(:provider => omniauth['provider'],:uid => omniauth['uid']).limit(1).first
      if authentication
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
        sign_in_and_redirect(:user, authentication.user)
      else
        user = User.new
        user.apply_omniauth(omniauth)

        if User.find_by_email(user.email)
          flash[:notice] = "A user with #{user.email} already exists."
          redirect_to new_user_registration_url
          return
        end

        # Confirmation  should only be for username/pass signups
        user.confirm!

        if user.save
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
          sign_in_and_redirect(:user, user)
        else
          session[:omniauth] = omniauth.except('extra')
          redirect_to new_user_registration_url
        end
      end
    end
  end

end