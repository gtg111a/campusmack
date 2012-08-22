class ApplicationController < ActionController::Base
  require 'will_paginate/array'

  APP_DOMAIN = 'www.campusmack.com'
  rescue_from Exception, :with => :render_error if Rails.env == 'production'

  protect_from_forgery
  include FaceboxRender
  include PostsHelper
  include SessionsHelper
  helper FaceboxRenderHelper

  before_filter :store_location, :only => [:index, :show]
  before_filter :store_location_edit, :only => [:index, :show]
  before_filter :init
  before_filter :add_initial_breadcrumbs
  before_filter :get_leftmenu_content
  before_filter :ensure_domain if Rails.env == 'production'

  rescue_from CanCan::AccessDenied do |exception|
    target_url = signed_in? ? root_url : sign_up_url
    flash[:alert] = exception.message
    if request.xhr?
      respond_to do |format|
        format.js { render :js => %Q{window.location = "#{target_url}";} }
      end
      return
    end
    redirect_to target_url
  end

  private

  def authenticate_admin!
    return if can? :access, :rails_admin
    raise CanCan::AccessDenied
  end

  def render_error(exception)
    raise if Rails.env == 'development'
    log_exception(exception)
    render :template => 'pages/500.html.erb', :status => 500
  rescue Exception
    render :file => 'public/500.html', :layout => false, :status => 500
  end

  def init
    @user_nav = []
    @main_menu = []
    session[:division] ||= Division.default
  end

  def add_initial_breadcrumbs
    breadcrumbs.add 'Home', '/'
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
    puts "\nEXCEPTION: #{exception}\n--------- BACKTRACE:\n#{exception.backtrace[0..4].join("\n")}\n--------- END OF BACKTRACE"
  end

  def ensure_domain
    return if Rails.env == 'staging' || request.local?
    return if request.env['HTTP_HOST'].ends_with?(APP_DOMAIN) || request.env['HTTP_HOST'].ends_with?('herokuapp.com')
    redirect_to "http://#{APP_DOMAIN}", :status => 301
  end
  
  def set_description
    @page_description = 'Funny campus and college memes, videos, articles. Find the college freshman meme and face meme here.'
  end

end
