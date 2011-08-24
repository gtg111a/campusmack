class WelcomeController < ApplicationController
  skip_authorization_check

  def index
    @colleges = College.all
    if signed_in?
      @micropost = Micropost.new if signed_in?
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end

end
