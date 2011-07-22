class SmacksController < ApplicationController
  
  def new
    @college = College.find(params[:college_id])
    @smack = @college.smacks.build
    @title = "Submit Smack"
  end
  
  def create
   @college = College.find(params[:college_id])
   @smack = @college.smacks.build(params[:smack])
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

end
  
