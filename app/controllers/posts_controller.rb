class PostsController < ApplicationController
  
  def new
    @post = post.new
  end
  
  def create
    @post = post.new
  end
  
  def index
    @college = College.find(params[:college_id])
    @title = "All posts from #{@college.name}"
    @posts = @college.posts.paginate(:page => params[:page])
  end
  
  def show
    @post = College.find(params[:id])
    @title = @college.name
    @posts = @college.posts.paginate(:page => params[:page])
  end
  
end
