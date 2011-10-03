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
    formatted_2nd_message = params[:message][:body2]
    formatted_2nd_message.gsub!(/\n/, '<br/>')
    msg = params[:message][:body1] + "<br>" + formatted_2nd_message
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
    @main_menu << [ @parent.name, @parent ]
    @main_menu << [ 'Smacks', eval("#{prefix}_smacks_path(@parent)") ]
    @main_menu << [ 'Redemptions', eval("#{prefix}_redemptions_path(@parent)") ]
  end

end
