class ServicesController < ApplicationController
  
  def create
    #try ["rack.auth"] if ["omniauth.auth"] doesn't work
    render :text => request.env["omniauth.auth"].to_yaml
  end
end
