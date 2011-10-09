class Users::SessionsController < Devise::SessionsController
  skip_authorization_check

  def new
    breadcrumbs.add 'Sign In', sign_in_path
    session.delete(:provider)
    super
  end

end
