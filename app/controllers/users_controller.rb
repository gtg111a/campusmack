require 'mailgun'

class UsersController < ApplicationController
  load_and_authorize_resource
  skip_authorization_check :only => [ :create, :new ]
  
  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end
  
  def show
    @order = params[:order] || 'created_at desc'
    @search = @user.posts.search(params[:search])
    @posts = @search.paginate(:page => params[:page], :order => @order)
    render :show
  end

  def following
    show_follow(:following)
  end
  
  def followers
    show_follow(:followers)
  end
  
  def show_follow(action)
    @title = action.to_s.capitalize
    @users = @user.send(action).paginate(:page => params[:page])
    render 'show_follow'
  end

  def smacks
    params[:search] ||= {}
    params[:search][:type_contains] = 'Smack'
    show
  end

  def redemptions
    params[:search] ||= {}
    params[:search][:type_contains] = 'Redemption'
    show
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

end



