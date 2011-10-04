class SmackSendsController < ApplicationController
  skip_authorization_check
  def index
    @smack_sends = SmackSend.all

  end

end
