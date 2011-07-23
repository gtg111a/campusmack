class PostsController < ApplicationController
  
  def new
    @user = current_user
    @college = College.find(params[:college_id])
    @post = @user.posts.build
    @title = "Submit Post"
  end
  
  def create
    @user = current_user
    @college = College.find(params[:college_id])
    @post = @user.posts.build(params[:post])
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
  
  def destroy
    @post = Post.find(params[:id])
    @college = College.find(@post.college_id)
    @post.destroy
    if @post.delete?
    redirect_to "/colleges/#{@college.id}/posts", :flash => { :success => "Post Deleted Successfully!" }
  end
end

 def edit
   @user = current_user
   @post = Post.find(params[:id])
   @title = "Edit post"
 end
 
 def update
   @post = Post.find(params[:id])
   if @post.update_attributes(params[:smack])
     redirect_to @post, :flash => { :success => "Post updated." }
   else
     @title = "Edit post"
     render 'edit'
   end
 end
  
end
