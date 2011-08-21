class Users::RegistrationsController < Devise::RegistrationsController

  def new
    resource = build_resource({})
    [:first_name, :last_name, :email, :username].each { |x| resource.send(x.to_s+'=', session.delete(x)) }
    respond_with_navigational(resource){ render_with_scope :new }
  end

  def create
    build_resource

    # Confirm the new account if the user used an external service to sign up
    if session[:provider]
      resource.confirm!
      authentication = Authentication.find(session[:provider])
      resource.authentications << authentication
    end

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => redirect_location(resource_name, resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end
  end
end