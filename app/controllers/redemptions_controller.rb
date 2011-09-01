class RedemptionsController < ApplicationController
  load_and_authorize_resource

  def new
    @user = current_user
    @college = College.find(params[:college_id])
    @redemption = @user.redemptions.build
    @title = "Submit Redemption"
    init_college_menu
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
    init_college_menu
    @colleges = College.all
    @user = current_user
    @title = "All redemptions from #{@college.name}"
    redemptions = @college.redemptions
    if [ 'video', 'photo', 'news', 'stat' ].include?(params[:content_type])
      redemptions = redemptions.send(params[:content_type].pluralize)
    end
    @search = redemptions.search(params[:search])
    @redemptions = @search.paginate(:page => params[:page])
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

end
