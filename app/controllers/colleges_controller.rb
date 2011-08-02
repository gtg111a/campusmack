class CollegesController < ApplicationController
  
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
    @user = current_user
    @college = College.find(params[:id])
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

end
