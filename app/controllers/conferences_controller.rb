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

  def show
    @conference = Conference.where(:name => params[:id].upcase).first
    @parent = @conference
    init_main_menu
    @search = @conference.posts.search(params[:search])
    @title = @conference.name
    if params[:search]
      @posts = @search.paginate(:page => params[:page], :order => 'created_at DESC')
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
      return college.posts.where(:content_type => "Video").paginate(:page => params[:page], :order => 'created_at DESC')
    elsif request.fullpath.to_s =~ /Photo/
      return college.posts.where(:content_type => "Photo").paginate(:page => params[:page], :order => 'created_at DESC')
    else
      return college.posts.paginate(:page => params[:page], :order => 'created_at DESC')
    end
  end

  def init_main_menu
    @main_menu << [@conference.name, @conference]
    @main_menu << ['Smacks', conference_smacks_path(@conference)]
    @main_menu << ['Redemptions', conference_redemptions_path(@conference)]
  end

end
