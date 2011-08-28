class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization
  include PostsHelper
  include SessionsHelper
  
  before_filter :store_location, :only => [:index, :show]
  before_filter :store_location_edit, :only => [:index, :show]
  before_filter :init_menu

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def init_menu
    @user_nav = []
    @main_menu = []
  end

  def init_college_menu
    @main_menu << [ 'Videos', college_path(@college, :content_type => "Video") ]
    @main_menu << [ 'Photos', college_path(@college, :content_type => "Photo") ]
    @main_menu << [ 'Smacks', posts_path(@college) ]
    @main_menu << [ 'Redemptions', posts_path(@college) ]
    @main_menu << [ 'News', '' ]
    @main_menu << [ 'Stats', '' ]
  end

end
