class Users::SessionsController < Devise::SessionsController

  def new
    session.delete(:provider)
    super
  end

end
