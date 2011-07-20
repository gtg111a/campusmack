class PostsController < ApplicationController
  
  def new
    @college = College.find(params[:college_id])
    @post = @college.posts.build
    @title = "Submit Post"
  end
  
  def create
    @college = College.find(params[:college_id])
    @post = @college.posts.build(params[:post])
    if @post.save
      redirect_to root_path, :flash => { :success => "Post Submitted Successfully!" }
    else
      @title = "Submit Post"
      render 'new'
    end
  end
  
  def index
    @college = College.find(params[:college_id])
    @title = "All posts from #{@college.name}"
    @posts = @college.posts.paginate(:page => params[:page], :order => 'created_at DESC')
  end
  
  def show
    @post = College.find(params[:id])
    @title = @college.name
    @posts = @college.posts.paginate(:page => params[:page], :order => 'created_at DESC')
  end
  
end
