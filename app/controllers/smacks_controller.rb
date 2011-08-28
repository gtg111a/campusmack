class SmacksController < ApplicationController
  skip_authorization_check :only => [ :index, :show ]
  load_and_authorize_resource

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
      redirect_to store_location, :flash => { :success => "Post Submitted Successfully!" }
    else
      @title = "Submit Smack"
      render 'new'
    end
  end
 
  def index
    @college = College.find(params[:college_id])
    @colleges = College.all
    @user = current_user
    @search = @college.smacks.search(params[:search])
    @title = "All smacks from #{@college.name}"
    if params[:search]
      @smacks = @search.paginate(:page => params[:page], :order => 'created_at DESC')
    else
      @smacks = find_smacks(@college)
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
    flash[:success] = "Post Deleted Successfully!"
      respond_to do |format|
      format.html { redirect_back_or(@user) }
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
      redirect_to user_path(current_user), :flash => { :success => "Post updated." }
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
  
