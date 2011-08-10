require 'mailgun'

class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :new, :create]
  #before_filter :correct_user, :only => [:edit, :update]
  #before_filter :admin_user, :only => :destroy
  
  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end
  
  def show
    if params[:college]
      @college = College.where("name =?", params[:college][:name]).first
    end
    @colleges = College.all
    @user = User.find(params[:id])
    @search = @user.posts.search(params[:search])
    @title = @user.name
    if params[:search]
      @posts = @search.paginate(:page => params[:page], :order => 'created_at DESC')
    else
      @posts = find_posts(@user)
    end
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
      UserMailer.welcome_email(@user).deliver
      redirect_to root_path, :flash => { :success => "Welcome to Campusmack!" }
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
    @user = current_user
  end
  
  def update
    @user = current_user
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
  

  private
  

    def find_posts(user)
      if request.fullpath.to_s =~ /Video/
        return user.posts.where(:content_type => "Video").paginate(:page => params[:page], :order => 'created_at DESC')
      elsif request.fullpath.to_s =~ /Photo/
        return user.posts.where(:content_type => "Photo").paginate(:page => params[:page], :order => 'created_at DESC') 
      else
        return user.posts.paginate(:page => params[:page], :order => 'created_at DESC')
      end
    end

    

=begin
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(@user)
    end
=end
end



