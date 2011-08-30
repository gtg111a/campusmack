class CommentsController < ApplicationController
   load_and_authorize_resource
  before_filter :find_commentable, :except => [:destroy, :edit]

  
  def find_commentable
    @commentable = Redemption.find(params[:redemption_id]) if params[:redemption_id]
    @commentable = Smack.find(params[:smack_id]) if params[:smack_id]
    @commentable = Post.find(params[:id]) if params[:id]
  
  end
  
  def create
    find_commentable 
    @college = College.find(@commentable.college_id)
    @comment = current_user.comments.create!(params[:comment].merge(
                                                        :commentable_id => @commentable.id, 
                                                        :commentable_type => "Post"))
   respond_to do |format|
   format.html { redirect_to "/colleges/#{@commentable.college_id}/posts/#{@commentable.id}" }
   format.js
    end
  end
  
    def destroy
      @comment = Comment.find(params[:id])
      @post = Post.find(@comment.commentable_id)
      @college = College.find(@post.college_id)
      @comment.destroy
      respond_to do |format|
      format.html { redirect_to "/colleges/#{@college.id}/posts/#{@post.id}", :flash => { :success => "Comment Deleted Successfully!" } }
      format.js
     end
    end

    def edit
      @user = current_user
      @comment = Comment.find(params[:id])
      @title = "Edit comment"
    end
    
    def update
      @comment = Comment.find(params[:id])
      @post = Post.find(@comment.commentable_id)
      if @comment.update_attributes(params[:comment])
        redirect_to "/colleges/#{@post.college_id}/posts/#{@post.id}", :flash => { :success => "Comment updated." }
      else
       redirect_to 'edit'
       @title = 'Edit comment'
      end
    end
  
  
end
