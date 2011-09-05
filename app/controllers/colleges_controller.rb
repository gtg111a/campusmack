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
    @parent = @college
    init_college_menu
    @search = @college.posts.search(params[:search])
    @title = @college.name
    if params[:search]
      @posts = @search.paginate(:page => params[:page], :order => 'created_at DESC')
    else
      @posts = find_posts(@college)
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

  def init_college_menu
    @main_menu << [ @college.name, @college ]
    @main_menu << [ 'Smacks', college_smacks_path(@college) ]
    @main_menu << [ 'Redemptions', college_redemptions_path(@college) ]
  end

end
