class WelcomeController < ApplicationController
  skip_authorization_check

  def index
    @colleges = College.all(:select => "colleges.*, COUNT(posts.id) number_of_smacks",
                            :conditions => 'type = "Smack"',
                            :joins => :posts,
                            :group => 'colleges.id',
                            :order => "number_of_smacks DESC",
                            :limit => 10)
    @sotw = Post.smack_of_week.first
    if signed_in?
      @micropost = Micropost.new if signed_in?
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end

end
