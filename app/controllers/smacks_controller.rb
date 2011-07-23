class SmacksController < ApplicationController
  
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
    @college = College.find(params[:college_id])
    @title = "All smacks from #{@college.name}"
    @smacks = @college.smacks.paginate(:page => params[:page], :order => 'created_at DESC')
  end
  
  def show
    @smack = Smack.find(params[:id])
     @college = College.find(@smack.college_id)
     @title = @college.name
  end
  
  def destroy
    @smack = Smack.find(params[:id])
    @college = College.find(@smack.college_id)
    @smack.destroy
    redirect_to "/colleges/#{@college.id}/smacks", :flash => { :success => "Post Deleted Successfully!" }
  end
  
  def edit
    @user = current_user
    @smack = Smack.find(params[:id])
    @title = "Edit post"
  end
  
  def update
    @smack = Smack.find(params[:id])
    if @smack.update_attributes(params[:smack])
      redirect_to @smack, :flash => { :success => "Post updated." }
    else
      @title = "Edit post"
      render 'edit'
    end
  end

end
  
