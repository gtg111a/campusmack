class SmacksController < ApplicationController
    include PostsHelper
  
  def new
    @user = current_user
    @college = College.find(params[:college_id])
    @smack = @user.smacks.build
    @title = "Submit Smack"
  end
  
  def create
   @user = current_user
   @college = College.find(params[:college_id])
   @smack = @college.smacks.build(params[:smack])
   @smack.user_id = @user.id
    if @smack.save
      redirect_to college_smacks_path, :flash => { :success => "Post Submitted Successfully!" }
    else
      @title = "Submit Smack"
      render 'new'
    end
  end
 
  def index
    @user = current_user
    @college = College.find(params[:college_id])
    @title = "All smacks from #{@college.name}"
    #@smacks = @college.smacks.paginate(:page => params[:page], :order => 'created_at DESC')
    @smacks = find_smacks(@college)
    respond_to do |format|
      format.html
      format.js
    end
  end

  
  def show
     @smack = Post.find(params[:id])
     @college = College.find(@smack.college_id)
     @title = @college.name
  end
  
  def destroy
    @user = current_user
    @smack = Smack.find(params[:id])
    @college = College.find(@smack.college_id)
    @smack.destroy
      respond_to do |format|
      format.html   { 
            redirect_to "/users/#{@user.id}", :flash => { :success => "Post Deleted Successfully!" } }
      format.js 
     end
  end
  
  def edit
    @user = current_user
    @smack = Smack.find(params[:id])
    @title = "Edit post"
  end
  
  def update
    @smack = Smack.find(params[:id])
    if @smack.update_attributes(params[:smack])
      redirect_to "/colleges/#{@smack.college_id}/posts/#{@smack.id}", :flash => { :success => "Post updated." }
    else
      @title = "Edit post"
      render 'edit'
    end
  end

private

  def find_smacks(college)
    if request.fullpath.to_s =~ /Video/
      return college.smacks.where(:content_type => "Video").paginate(:page => params[:page], :order => 'created_at DESC')
    elsif request.fullpath.to_s =~ /Photo/
      return college.smacks.where(:content_type => "Photo").paginate(:page => params[:page], :order => 'created_at DESC') 
    else
      return college.smacks.paginate(:page => params[:page], :order => 'created_at DESC')
    end
  end

end
  
