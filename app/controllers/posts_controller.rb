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
    @user = current_user
    @college = College.find(params[:college_id])
    @title = "All posts from #{@college.name}"
    @posts = @college.posts.paginate(:page => params[:page], :order => 'created_at DESC')
  end
  
  def show
    @college = College.find(params[:college_id])
    @post = Post.find(params[:id])
    @comments = Comment.find(:all, :conditions => {:commentable_id => @post.id}).paginate(:page => params[:page], :order => 'created_at DESC')
    #@comments = @post.comments.paginate(:page => params[:page], :order => 'created_at DESC')
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
   if @post.update_attributes(params[:post])
     redirect_to college_post_path, :flash => { :success => "Post updated." }
   else
     @title = "Edit post"
     render 'edit'
   end
 end
 
 def update(vote)
   @post = Post.find(params[:id])
   if vote == "Vote Up"
     current_user.up_vote(@post)
   end
   if vote == "Vote Down"
     current_user.down_vote(@post)
   end
 end
 
  
end
