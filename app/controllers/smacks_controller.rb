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
   # @smacker = college_smacks(@college)
    @smacks = @college.smacks.paginate(:page => params[:page], :order => 'created_at DESC')
  end
  
  def show
    @smack = College.find(params[:id])
    @title = @college.name
    @smacks = @college.smacks.paginate(:page => params[:page], :order => 'created_at DESC')
  end
  
  def destroy
    @smack.destroy
    root_path
  end

private

#Tried this method to display only smacks from the Posts.db, didn't work
=begin 
 def college_smacks(college)
   @newcollege = College.new
   college.posts.each do |f|
     if f.post_type == "Smack"
       @newcollege.posts << f
     end
   end
   return @newcollege
 end
=end
end
  
