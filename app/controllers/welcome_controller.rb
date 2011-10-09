class WelcomeController < ApplicationController
  skip_authorization_check

  def index
    @colleges = College.all(:order => "smacks_count DESC", :limit => 10)
    @sotw = Post.smack_of_week.first
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
