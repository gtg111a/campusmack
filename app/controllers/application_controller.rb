class ApplicationController < ActionController::Base
  rescue_from Exception, :with => :render_error

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
    redirect_to signed_in? ? root_url : sign_up_url, :alert => exception.message
  end

  private

  def render_error(exception)
    logger.error exception.to_s
    logger.error exception.backtrace.join("\n")
    render :template => 'pages/500.html.erb', :status => 500
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
