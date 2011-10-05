class PagesController < ApplicationController
  skip_authorization_check

  def home
    @title = "Home"
    @colleges = College.all
    if signed_in?
      @micropost = Micropost.new if signed_in?
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end

  def about
    breadcrumbs.add 'About Us', '/about'
  end

  def help
    @title = "Help"
  end

end

