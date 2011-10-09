class ConferencesController < ApplicationController
  authorize_resource

  def new
    @conference = Conference.new
  end

  def create
    @conference = Conference.new(:name)
  end

  def index
    @conferences = Conference.all
  end

  def status
    breadcrumbs.add 'Statistics', '/conference_stats'
    @conferences = Conference.where(:division => session[:division])
  end

  def show
    @conference = Conference.where(:name => params[:id].upcase).first
    @parent = @conference
    init_main_menu
    breadcrumbs.add @conference.name, conference_path(@conference)
    @order = params[:order] || 'created_at desc'
    @search = @conference.posts.search(params[:search])
    @title = @conference.name
    if params[:search]
      @posts = @search.paginate(:page => params[:page], :order => @order)
    else
      @posts = find_posts(@conference)
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

  def init_main_menu
    @main_menu << [ :text, 'All', '', 'active' ]
    @main_menu << [ :link, 'Smacks', conference_smacks_path(@conference)]
    @main_menu << [ :link, 'Redemptions', conference_redemptions_path(@conference)]
  end

end
