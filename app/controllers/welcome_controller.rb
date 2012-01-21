class WelcomeController < ApplicationController

  def index
    @colleges = College.all(:order => "smacks_count DESC", :limit => 10)
    @featured_articles = Post.published.where(:type => 'ArticlePost').order('created_at DESC').limit(4)
  end

  def change_division
    session[:division] = params['division']
    redirect_to :back
  end

end
