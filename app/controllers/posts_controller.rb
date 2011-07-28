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
 
 def vote_up
      begin
         current_user.vote_for(@post = Post.find(params[:id]))
         redirect_to "/colleges/#{@post.college_id}/#{@post.type.downcase}s", :flash => {:success => "Bonny Rike!!!"}
       rescue ActiveRecord::RecordInvalid
         redirect_to "/colleges/#{@post.college_id}/#{@post.type.downcase}s", :flash => {:error => "You've already voted for this Post"}
       end
     end
 
 def vote_down
   begin
       current_user.vote_against(@post = Post.find(params[:id]))
       redirect_to "/colleges/#{@post.college_id}/#{@post.type.downcase}s", :flash => {:success => "Bonny No Rike :("}
     rescue ActiveRecord::RecordInvalid
        redirect_to "/colleges/#{@post.college_id}/#{@post.type.downcase}s", :flash => {:error => "You've already voted for this Post"}
     end
   end

  
end
