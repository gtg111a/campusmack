class Users::SessionsController < Devise::SessionsController
  skip_authorization_check

  def new
    session.delete(:provider)
    super
  end

end
