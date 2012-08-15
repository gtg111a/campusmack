class WelcomeController < ApplicationController

  def index
    @colleges = College.all(:order => "smacks_count DESC", :limit => 10)
    @featured_articles = Post.published.where(:type => 'ArticlePost').order('created_at DESC').limit(4)
    @home_list = []
    @posts = Post.published.order('created_at DESC').limit(50)
    @posts.each do |post|
      if @home_list.size < 20
      @home_list << post if post.video || post.photo
      end
    end
    @sotw = Post.smacks_of_week
  end

  def change_division
    session[:division] = params['division']
    redirect_to :back
  end

end
