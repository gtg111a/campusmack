class AuthenticationsController < ApplicationController
  load_and_authorize_resource

  # GET all authentication services assigned to the current user
  def index
    @services = current_user.authentications.order('provider asc')
    @available_services = []
    User.omniauth_providers.each do |s|
      next if current_user.authentications.where(:provider => s.to_s).any?
      @available_services << s
    end
  end

  # POST to remove an authentication service
  def destroy
    # remove an authentication service linked to the current user
    @service = current_user.authentications.find(params[:id])

    if session[:provider] == @service.id
      flash[:error] = 'You are currently signed in with this account!'
    else
      @service.destroy
    end

    redirect_to authentications_path
  end

end
