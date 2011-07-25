class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  
  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end
  
  def show
    @colleges = College.all
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(:page => params[:page], :order => 'created_at DESC')
    @title = @user.name
  end

  def following
   show_follow(:following)
  end
  
  def followers
    show_follow(:followers)
  end
  
  def show_follow(action)
    @title = action.to_s.capitalize
    @user = User.find(params[:id])
    @users = @user.send(action).paginate(:page => params[:page])
    render 'show_follow'
  end

  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to root_path, :flash => { :success => "Welcome to Campusmack!" }
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile updated." }
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, :flash => { :success => "User destroyed." }
  end
  
  def update(vote)
    @post = Post.find(params[:id])
    if vote == "Vote Up"
      current_user.up_vote(@post)
    end
    if vote == "Vote Down"
      current_user.down_vote(@post)
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(@user)
    end
end



