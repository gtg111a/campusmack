class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :services, :only => [:edit, :update]
  skip_authorization_check :only => [:new, :create]
  load_and_authorize_resource :class => 'User', :except => [:new, :create]

  def new
    breadcrumbs.add 'Signing Up'
    resource = build_resource({})
    [:first_name, :last_name, :email, :username].each { |x| resource.send(x.to_s+'=', session.delete(x)) }
    respond_with_navigational(resource) { render_with_scope :new }
  end

  def create
    breadcrumbs.add 'Signing Up'
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

  def edit
    breadcrumbs.add 'Editing Profile'
    render_with_scope :edit
  end

  def update
    if params[resource_name][:password].blank? && params[resource_name][:password_confirmation].blank? && params[resource_name][:password_confirmation].blank?
      params[resource_name].delete(:password)
      params[resource_name].delete(:password_confirmation)
      params[resource_name].delete(:current_password)
    end

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.update_with_password(params[resource_name])
      set_flash_message :notice, :updated if is_navigational_format?
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :edit }
    end
  end

  private

  def services
    @services = current_user.authentications.order('provider asc')
    @available_services = []
    User.omniauth_providers.each do |s|
      next if current_user.authentications.where(:provider => s.to_s).any?
      @available_services << s
    end
  end


end