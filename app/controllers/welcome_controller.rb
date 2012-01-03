class WelcomeController < ApplicationController

  def index
    @colleges = College.all(:order => "smacks_count DESC", :limit => 10)
    # FIXME
    @featured_articles = Post.where(:type => 'ArticlePost').limit(4)
  end

  def change_division
    session[:division] = params['division']
    redirect_to :back
  end

end
