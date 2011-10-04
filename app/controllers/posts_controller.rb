# This is tricky. It handles smacks, redemptions and all the different post types (videos, photos, news, stats)
class PostsController < ApplicationController
  respond_to :js, :html
  skip_authorization_check
  load_and_authorize_resource
  skip_authorize_resource :only => [:opengraph, :share_through_email_form,:share_through_email]
  before_filter :authenticate_user!, :except => [:show, :index, :opengraph, :share_through_email_form,:share_through_email]
  include PostsHelper

  before_filter :find_parent

  def new
    @post = @parent.send(@post_cls).build
    @title = 'Submit a ' + @parent.name + ' ' + @post.class.to_s.titleize
    init_college_menu
    add_breadcrumbs
    render 'posts/new'
  end

  def create
    @post = @parent.send(@post_cls).build(params[@post_cls.singularize])
    @post.user = current_user
    if @post.save
      if store_location =~ /^\/conferences\//
        redirect_to conference_path(@parent)
      else
        redirect_to store_location, :flash => {:success => "#{@parent.name} #{@post.class.to_s.titleize} Submitted Successfully!"}
      end
    else
      render 'posts/new'
    end
  end

  def index
    @title = @parent.name + " #{@post_cls.titleize}"
    posts = if ['smacks', 'redemptions'].include?(@post_cls)
      @parent.send(@post_cls)
    else
      @parent.posts.joins(@post_cls.singularize.to_sym)
    end
    @search = posts.search(params[:search])
    @order = params[:order] || 'created_at desc'
    @posts = @search.paginate(:page => params[:page], :order => @order)
    init_college_menu
    add_breadcrumbs
    if request[:controller] == 'videos' || request[:controller] == 'photos' || request[:controller] == 'news_posts' || request[:controller] == 'statistics'
      title = request[:controller].capitalize
      title = "News" if request[:controller] == 'news_posts'
      title = "Stats" if request[:controller] == 'statistics'
      breadcrumbs.add title, method("#{@parent.class.name.downcase}_#{title.downcase}#{"_index" if request[:controller] == 'news_posts'}_path").call(@parent)
    end

    # We use the views from the posts folder for everything
    render 'posts/index'
  end

  def show
    @post = Post.find(params[:id])
    @post.censored_text(@post.title, current_user)
    @post.censored_text(@post.summary,current_user)
    @comments = Comment.find(:all, :conditions => {:commentable_id => @post.id}).paginate(:page => params[:page], :order => 'created_at DESC')
    @title = "#{@parent.name} #{@post.class.to_s.titleize}"
    init_college_menu
    render 'posts/show'
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Post Deleted Successfully!"
    respond_to do |format|
      format.html { redirect_after_destroy_back_or(@user) }
      format.js
    end
  end

  def report
    unless params[:report][:reason_id].blank?
      reason = Reason.find(params[:report][:reason_id].to_i)
    else
      reason = nil
    end
    @post.reports.create!(:user => current_user, :reason => reason, :custom_reason => params[:report][:other])
    respond_to do |format|
      format.html { flash[:success] = "Post Reported to Site Admin"; redirect_back_or(@post) }
      format.js
    end
  end

  def edit
    @user = current_user
    @post = Post.find(params[:id])
    @title = "Edit post"
    render 'posts/edit'
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[@post.type.downcase])
      redirect_to user_path(current_user), :flash => {:success => "Post updated."}
    else
      @title = "Edit post"
      render 'edit'
    end
  end

  def vote_up
    @user = current_user
    @post = Post.find(params[:id])
    vote_check_for(@post)
    respond_to do |format|
      format.html { redirect_to "/colleges/#{@post.college_id}/#{@post.type.downcase}s", :flash => {:success => "Vote up successful."} }
      format.js
    end
  end

  def vote_down
    @user = current_user
    @post = Post.find(params[:id])
    vote_check_against(@post)
    respond_to do |format|
      format.html { redirect_to "/colleges/#{@post.college_id}/#{@post.type.downcase}s", :flash => {:success => "Vote down successful."} }
      format.js
    end
  end

  def opengraph
    @post = Post.find(params[:id])
  end

  def share_through_email_form
    @post = Post.find(params[:id])
    @post.censored_text(@post.title, current_user)
    @post.censored_text(@post.summary,current_user)
    @user = current_user
    @to_emails = ""
    #@to_emails = current_user.contacts().collect(&:email).join(", ") if(params[:smack].present?) # is is added to collect emails brom db and populate the text area with emails
    respond_with(@post) do |format|
      format.js { render_to_facebox }
    end
  end

  def share_through_email
    @post = Post.find(params[:id])
    @post.censored_text(@post.title, current_user)
    @post.censored_text(@post.summary,current_user)
    inc_count=0
    if params[:smack] == "1"
      inc_count=1
    else
      inc_count=0
    end
    title=params[:message][:title]
    @message = nil
    msg = params[:message][:body1] + "<br>" + params[:message][:body2]
    if !params[:cb_email].present?
      @message = Struct.new(:to, :body).new(params[:message][:to], msg)
    else
      @message = Struct.new(:to, :body).new(params[:cb_email].join(",") + "," + params[:message][:to], msg)
    end
    respond_with(@post) do |format|
      if(@message.to.present? && @message.body.present?)
        puts "Ok found"
        UserMailer.share_post(@post, current_user,title, @message, inc_count).deliver
        flash[:notice] = "<b>#{ @post.title}</b> is shared successfully!".html_safe
        
      else
        flash[:error] = 'Error while sharing post!'
      end
      #  flash[:error] = 'Error while sharing post!'
      format.js
    end
  end

  protected

  def find_parent
    @parent = College.where(:permalink => params[:college_id]).first
    @parent ||= Conference.where(:name => params[:conference_id]).first
    @post_cls = self.class.to_s.underscore.gsub('_controller','')
  end

  def init_college_menu
    prefix = @parent.class.to_s.downcase
    @main_menu << [ :link, 'All', @parent, '' ]
    if @post_cls == 'smacks'
      @main_menu << [ :text, 'Smacks', '', 'active' ]
    else
      @main_menu << [ :link, 'Smacks', eval("#{prefix}_smacks_path(@parent)"), '' ]
    end
    if @post_cls == 'redemptions'
      @main_menu << [ :text, 'Redemptions', '', 'active' ]
    else
      @main_menu << [ :link, 'Redemptions', eval("#{prefix}_redemptions_path(@parent)"), '' ]
    end
  end

  def add_breadcrumbs
    if @parent.class.name == 'Conference'
      breadcrumbs.add @parent.name, conference_path(@parent)
    else
      breadcrumbs.add @parent.conference.name, conference_path(@parent.conference)
    end
    breadcrumbs.add @parent.name, college_path(@parent) if @parent.class.name == 'College'
    @main_menu.each do |x|
      breadcrumbs.add x[1], x[2] if x[1] == @post_cls.titleize
    end
    breadcrumbs.add params[:action].gsub(/new|create/, 'Add')
  end

end
