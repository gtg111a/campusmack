class RedemptionsController < ApplicationController
  
  def new
    @user = current_user
    @college = College.find(params[:college_id])
    @redemption = @user.redemptions.build
    @title = "Submit Redemption"
  end
  
  def create
   @user = current_user
   @college = College.find(params[:college_id])
   @redemption = @college.redemptions.build(params[:redemption])
   @redemption.user_id = @user.id
    if @redemption.save
      redirect_to college_redemptions_path, :flash => { :success => "Post Submitted Successfully!" }
    else
      @title = "Submit Redemption"
      render 'new'
    end
  end
     
    def index
      @college = College.find(params[:college_id])
      @title = "All redemptions from #{@college.name}"
      @redemptions = @college.redemptions.paginate(:page => params[:page], :order => 'created_at DESC')
    end

    def show
      @redemption = Redemption.find(params[:id])
      @college = College.find(@redemption.college_id)
      @title = @college.name
    end
    
    def destroy
      @redemption = Redemption.find(params[:id])
      @college = College.find(@redemption.college_id)
      @redemption.destroy
      redirect_to "/colleges/#{@college.id}/redemptions", :flash => { :success => "Post Deleted Successfully!" }  
    end
    
=begin
private
  
  def find_redemptions
    @college = College.find(params[:college_id])
    @college.posts.each do |f|
      if f.post_type = "Redemption"
        return f
      end
    end
    nil
  end
=end
end
