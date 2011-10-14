class CommentsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_commentable, :except => [:destroy, :edit, :update]

  def find_commentable
    @commentable = Redemption.find(params[:redemption_id]) if params[:redemption_id]
    @commentable = Smack.find(params[:smack_id]) if params[:smack_id]
    @commentable = Post.find(params[:id]) if params[:id]
  end

  def create
    @comment = @commentable.comments.create!(params[:comment].merge(:user_id => current_user.id))
    respond_to do |format|
      format.html { redirect_to [ @commentable.postable, @commentable ] }
      format.js
    end
  end

  def destroy
    @commentable = @comment.commentable
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to [ @commentable.postable, @commentable ], :flash => {:success => "Comment Deleted Successfully!"} }
      format.js
    end
  end

  def edit
    @user = current_user
    @title = "Edit comment"
  end

  def update
    @post = Post.find(@comment.commentable_id)
    if @comment.update_attributes(params[:comment])
      redirect_to [ @comment.commentable.postable, @post ], :flash => {:success => "Comment updated."}
    else
      redirect_to 'edit'
      @title = 'Edit comment'
    end
  end

  def report
    @comment.reports.create!(:user => current_user)
    respond_to do |format|
      format.html { redirect_to [@comment.commentable.postable, @comment.commentable], :flash => {:success => "This comment has been reported to our site admin."} }
      format.js
    end
  end

end
