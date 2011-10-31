class SmackSendsController < ApplicationController
  def index
    @smack_sends = SmackSend.all
  end

end
