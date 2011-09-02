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
    @user = current_user
    @title = "All posts"
    posts = @college.posts
    if [ 'video', 'photo', 'news', 'stat' ].include?(params[:content_type])
      posts = posts.send(params[:content_type].pluralize)
    end
    @search = posts.search(params[:search])
    @posts = @search.paginate(:page => params[:page])
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

  def report
    @post = Post.find(params[:id])
    @post.increment!(:report_count)
    flash[:success] = "Post Reported to Site Admin"
    respond_to do |format|
      format.html { redirect_back_or(@post) }
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


end
