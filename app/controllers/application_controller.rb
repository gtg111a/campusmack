class ApplicationController < ActionController::Base
  protect_from_forgery
  include FaceboxRender
  include PostsHelper
  include SessionsHelper

  before_filter :store_location, :only => [:index, :show]
  before_filter :store_location_edit, :only => [:index, :show]
  before_filter :init
  before_filter :add_initial_breadcrumbs
  before_filter :get_leftmenu_content

  rescue_from CanCan::AccessDenied do |exception|
    logger.error exception.backtrace.join("\n")
    redirect_to root_url, :alert => exception.message
  end

  def init
    @user_nav = []
    @main_menu = []
    session[:division] ||= 'I-A'
  end

  def add_initial_breadcrumbs
    breadcrumbs.add 'Home', root_path
  end

  def get_leftmenu_content
    @conferences = Conference.where(:division => session[:division])
  end
end
