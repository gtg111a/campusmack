class CollegesController < ApplicationController
  authorize_resource

  def new
    @college = College.new
  end

  def create
    @college = College.new(:name)
  end

  def index
    @colleges = College.all
  end

  def show
    @college = College.where(:permalink => params[:id]).first
    @conference = @college.conference
    @parent = @college
    breadcrumbs.add @college.conference.name, conference_path(@college.conference)
    breadcrumbs.add @college.name
    init_college_menu
    @order = params[:order] || 'created_at desc'
    @search = @college.posts.search(params[:search])
    @title = @college.name
    if params[:search]
      @posts = @search.paginate(:page => params[:page], :order => @order)
    else
      @posts = find_posts(@college)
    end
    @articles, @videos, @photos, @news = [], [], [], []
    @posts.each do |post|
      @articles << post if post.article && post.published && @articles.size < 3
      @videos << post if post.video && @videos.size < 4
      @photos << post if post.photo && @photos.size < 4
      @news << post if post.news_post && @news.size < 8
    end
  end

  def vote_up
    @post = post
    @user = current_user
    @user.up_vote(@post)
    redirect_to root_path
  end

  def vote_down(post)
    @post = post
    @user = current_user
    @user.down_vote(@post)
  end


  private

  def find_posts(college)
    if request.fullpath.to_s =~ /Video/
      return college.posts.where(:content_type => "Video").paginate(:page => params[:page], :order => @order)
    elsif request.fullpath.to_s =~ /Photo/
      return college.posts.where(:content_type => "Photo").paginate(:page => params[:page], :order => @order)
    else
      return college.posts.paginate(:page => params[:page], :order => @order)
    end
  end

  def init_college_menu
    @main_menu << [ :text, 'All', '', 'active' ]
    @main_menu << [ :link, 'Smacks', college_smacks_path(@college) ]
    @main_menu << [ :link, 'Redemptions', college_redemptions_path(@college) ]
  end

end
