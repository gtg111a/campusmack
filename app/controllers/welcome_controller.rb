class WelcomeController < ApplicationController

  def index
    @colleges = College.all(:order => "smacks_count DESC", :limit => 10)
  end

  def change_division
    session[:division] = params['division']
    redirect_to :back
  end

end
