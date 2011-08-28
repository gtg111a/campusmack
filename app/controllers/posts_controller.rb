class PostsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:show, :index]
  include PostsHelper

  def new
    @user = current_user
    @college = College.find(params[:college_id])
    @post = @user.posts.build
    @title = "Submit Post"
    init_college_menu
  end

  def create
    @user = current_user
    @college = College.find(params[:college_id])
    @post = @user.posts.build(params[:post])
    if @post.save
      redirect_to store_location, :flash => {:success => "Post Submitted Successfully!"}
    else
      @title = "Submit Post"
      render 'new'
    end
  end

  def index
    @college = College.find(params[:college_id])
    @search = Post.search(params[:search])
    @user = current_user
    @title = "All posts"
    if params[:search]
      @posts = @search.paginate(:page => params[:page], :order => 'created_at DESC')
    else
      @posts = find_posts
    end
    init_college_menu
  end

  def show
    @college = College.find(params[:college_id])
    @post = Post.find(params[:id])
    @comments = Comment.find(:all, :conditions => {:commentable_id => @post.id}).paginate(:page => params[:page], :order => 'created_at DESC')
    @title = @college.name
    @posts = @college.posts.paginate(:page => params[:page], :order => 'created_at DESC')
    init_college_menu
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    @college = College.find(@post.college_id)
    @post.destroy
    flash[:success] = "Post Deleted Successfully!"
    respond_to do |format|
      format.html { redirect_back_or(@user) }
      format.js
    end
  end

  def edit
    @user = current_user
    @post = Post.find(params[:id])
    @title = "Edit post"
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to user_path(current_user), :flash => {:success => "Post updated."}
    else
      @title = "Edit post"
      render 'edit'
    end
  end

  def vote_up
    @user = current_user
    @post = Post.find(params[:id])
    vote_check_for(@post)
    respond_to do |format|
      format.html { redirect_to "/colleges/#{@post.college_id}/#{@post.type.downcase}s", :flash => {:success => "Vote up successful."} }
      format.js
    end
  end

  def vote_down
    @user = current_user
    @post = Post.find(params[:id])
    vote_check_against(@post)
    respond_to do |format|
      format.html { redirect_to "/colleges/#{@post.college_id}/#{@post.type.downcase}s", :flash => {:success => "Vote down successful."} }
      format.js
    end
  end

  private

  def find_posts
    if request.fullpath.to_s =~ /Video/
      return Post.find(:all, :conditions =>["posts.content_type LIKE ?", "Video"]).paginate(:page => params[:page], :order => 'created_at DESC')
    elsif request.fullpath.to_s =~ /Photo/
      return Post.find(:all, :conditions =>["posts.content_type LIKE ?", "Photo"]).paginate(:page => params[:page], :order => 'created_at DESC')
    elsif request.fullpath.to_s =~ /Smack/
      return Post.find(:all, :conditions =>["posts.type LIKE ?", "Smack"]).paginate(:page => params[:page], :order => 'created_at DESC')
    elsif request.fullpath.to_s =~ /Redemption/
      return Post.find(:all, :conditions =>["posts.type LIKE ?", "Redemption"]).paginate(:page => params[:page], :order => 'created_at DESC')
    else
      return Post.all.paginate(:page => params[:page], :order => 'created_at DESC')
    end
  end


end
