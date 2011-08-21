class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!

  # GET all authentication services assigned to the current user
  def index
    @services = current_user.authentications.order('provider asc')
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