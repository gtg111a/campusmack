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
    target_url = signed_in? ? root_url : sign_up_url
    flash[:alert] = exception.message
    if request.post?
      respond_to do |format|
        format.js { render(:update) { |page| page.redirect_to target_url } }
      end
      return
    end
    redirect_to target_url
  end

  private

  def render_error(exception)
    log_exception(exception)
    render :template => 'pages/500.html.erb', :status => 500
  end

  def init
    @user_nav = []
    @main_menu = []
    session[:division] ||= Division.default
  end

  def add_initial_breadcrumbs
    breadcrumbs.add 'Home', root_path
  end

  def add_breadcrumbs
    controller, action = params[:controller], params[:action]

    # The main breadcrumb
    breadcrumbs.add controller.underscore.titlecase, contacts_path

    unless action == "index" # No breadcrumbs needed for the index page
      # Breadcrumb for the actual page, notice the conventions used.
      breadcrumbs.add "#{action}_#{controller.singularize}".titlecase
    end
  end

  def get_leftmenu_content
    @conferences = Conference.where(:division => session[:division])
  end

  def log_exception(exception)
    puts "\nEXCEPTION: #{exception}\n"
    puts "--------- BACKTRACE:\n#{exception.backtrace[0..4].join("\n")}\n--------- END OF BACKTRACE" if exception.backtrace.any?
  end

end
