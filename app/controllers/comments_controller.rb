class CommentsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_commentable, :except => [:destroy, :edit]

  def find_commentable
    @commentable = Redemption.find(params[:redemption_id]) if params[:redemption_id]
    @commentable = Smack.find(params[:smack_id]) if params[:smack_id]
    @commentable = Post.find(params[:id]) if params[:id]
  end
  
  def create
    @comment = @commentable.comments.create!(params[:comment].merge(:user_id => current_user.id))
    respond_to do |format|
      format.html { redirect_to @commentable }
      format.js
    end
  end
  
    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      respond_to do |format|
      format.html { redirect_to @comment.commentable, :flash => { :success => "Comment Deleted Successfully!" } }
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
