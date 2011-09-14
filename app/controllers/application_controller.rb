class ApplicationController < ActionController::Base
  protect_from_forgery
  include FaceboxRender
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

end
