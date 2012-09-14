class UsersController < ApplicationController

  skip_authorization_check :only => [ :create, :new, :plaxo_import ]
  load_and_authorize_resource

  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end

  def show
    @order = params[:order] || 'created_at desc'
    @search = @user.posts.search(params[:search])
    @posts = @search.paginate(:page => params[:page], :order => @order, :per_page => 50)

    respond_to do |format|
      format.json do
        unless @posts.blank?
          render :json => {
              :posts => render_to_string(:partial => 'posts/summary.html.erb', :collection => @posts, :as => :post),
              :next_page => @posts.next_page
          }
        else
          render :json => {:error => 'No more posts to load.'}, :status => 404
        end
      end
      format.html do
        breadcrumbs.add @user.username
        init_college_menu

        # We use the views from the posts folder for everything
        render :show
      end
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
    @users = @user.send(action).paginate(:page => params[:page])
    render :show_follow
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
      render :new
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
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, :flash => { :success => "User destroyed." }
  end

  def plaxo_import
    @user = current_user
  end

protected

def init_college_menu
  @action = params[:action]
    if @action == 'show'
      @main_menu << [ :text, 'All', @parent, 'active' ]
    else
      @main_menu << [ :link, 'All', user_path(@user), '' ]
    end
    if @action == 'smacks'
      @main_menu << [ :text, 'Smacks', '', 'active' ]
    else
      @main_menu << [ :link, 'Smacks', user_smacks_path(@user), '' ]
    end
    if @action == 'redemptions'
      @main_menu << [ :text, 'Redemptions', '', 'active' ]
    else
      @main_menu << [ :link, 'Redemptions', user_redemptions_path(@user), '' ]
    end
  end

end
