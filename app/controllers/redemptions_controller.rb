class RedemptionsController < ApplicationController
  load_and_authorize_resource

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
      redirect_to store_location, :flash => {:success => "Post Submitted Successfully!"}
    else
      @title = "Submit Redemption"
      render 'new'
    end
  end

  def index
    @college = College.find(params[:college_id])
    @colleges = College.all
    @user = current_user
    @search = @college.redemptions.search(params[:search])
    @title = "All redemptions from #{@college.name}"
    if params[:search]
      @redemptions = @search.paginate(:page => params[:page], :order => 'created_at DESC')
    else
      @redemptions = find_redemptions(@college)
    end
  end

  def show
    @redemption = Post.find(params[:id])
    @college = College.find(@redemption.college_id)
    @title = @college.name
  end

  def destroy
    @user = current_user
    @redemption = Redemption.find(params[:id])
    @college = College.find(@redemption.college_id)
    @redemption.destroy
    flash[:success] = "Post Deleted Successfully!"
    respond_to do |format|
      format.html { redirect_back_or(@user) }
      format.js
    end
  end

  def edit
    @url = request.referrer
    @user = current_user
    @redemption = Redemption.find(params[:id])
    @title = "Edit post"
  end

  def update
    @redemption = Redemption.find(params[:id])
    if @redemption.update_attributes(params[:redemption])
      redirect_to user_path(current_user), :flash => {:success => "Post updated."}
    else
      @title = "Edit post"
      render 'edit'
    end
  end

  private

  def find_redemptions(college)
    if request.fullpath.to_s =~ /Video/
      return college.redemptions.where(:content_type => "Video").paginate(:page => params[:page], :order => 'created_at DESC')
    elsif request.fullpath.to_s =~ /Photo/
      return college.redemptions.where(:content_type => "Photo").paginate(:page => params[:page], :order => 'created_at DESC')
    else
      return college.redemptions.paginate(:page => params[:page], :order => 'created_at DESC')
    end
  end
end
