class RedemptionsController < ApplicationController
  
  def new
    @college = College.find(params[:college_id])
    @redemption = @college.redemptions.build
    @title = "Submit Redemption"
  end
  
  def create
   @college = College.find(params[:college_id])
   @redemption = @college.redemptions.build(params[:redemption])
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
      @redemption = College.find(params[:id])
      @title = @college.name
      @redemptions = @college.redemptions.paginate(:page => params[:page], :order => 'created_at DESC')
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
