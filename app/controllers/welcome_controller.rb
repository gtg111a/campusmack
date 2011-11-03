class WelcomeController < ApplicationController

  def index
    @colleges = College.all(:order => "smacks_count DESC", :limit => 10)
    if signed_in?
      @micropost = Micropost.new if signed_in?
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end

  def change_division
    session[:division] = params['division']
    redirect_to :back
  end

end
