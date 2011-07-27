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
    @college = College.find(params[:id])
    @title = @college.name
    @posts = @college.posts.paginate(:page => params[:page], :order => 'created_at DESC')
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

#Don't need this, saving just in case
=begin 
private
  def all_posts(college)
    college.redemptions.each do |f|
      college.posts << f
    end
    college.smacks.each do |f|
      college.posts << f
    end
    return college
  end
=end

end
