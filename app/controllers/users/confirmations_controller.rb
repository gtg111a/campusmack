class Users::ConfirmationsController < Devise::ConfirmationsController
  skip_authorization_check
end
