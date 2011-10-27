# This is tricky. It handles smacks, redemptions and all the different post types (videos, photos, news, stats)
class PostsController < ApplicationController
  respond_to :js, :html
  authorize_resource
  skip_authorize_resource :only => [:opengraph, :share_through_email_form,:share_through_email]
  before_filter :authenticate_user!, :except => [:show, :index, :opengraph, :share_through_email_form,:share_through_email]
  include PostsHelper

  before_filter :find_post, :except => [ :new, :create, :index ]
  before_filter :find_parent, :except => [ :send_as_smack, :send_in_email ]

  def new
    @post = @parent.send(@post_cls).build
    @title = 'Submit a ' + @parent.name + ' ' + @post.class.to_s.titleize
    @submit = 'FILL IN THE FOLLOWING TO SUBMIT A ' + @post.class.to_s.upcase
    init_college_menu
    add_breadcrumbs
    render 'posts/new'
  end

  def create
    @post = @parent.send(@post_cls).build(params[@post_cls.singularize])
    @post.user = current_user
    init_college_menu
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
    if @parent
      @title = @parent.name + " #{@post_cls.titleize}"
      posts = if ['smacks', 'redemptions'].include?(@post_cls)
        @parent.send(@post_cls)
      else
        @parent.posts.joins(@post_cls.singularize.to_sym)
      end
    else
      @title = "All Posts"
      posts = case @post_cls
      when 'smacks'
        Smack
      when 'redemptions'
        Redemption
      when 'photos', 'videos', 'news_posts'
        Post.joins(@post_cls.singularize.to_sym)
      else
        Post
      end
    end
    @search = posts.search(params[:search])
    @order = params[:order] || 'created_at desc'
    @posts = @search.paginate(:page => params[:page], :order => @order)
    init_college_menu
    add_breadcrumbs

    # We use the views from the posts folder for everything
    render 'posts/index'
  end

  def show
    @post.censored_text(@post.title, current_user)
    @post.censored_text(@post.summary,current_user)
    @comments = Comment.find(:all, :conditions => {:commentable_id => @post.id}).paginate(:page => params[:page], :order => 'created_at DESC')
    @title = "#{@parent.name} #{@post.class.to_s.titleize}"
    init_college_menu
    add_breadcrumbs
    render 'posts/show'
  end

  def destroy
    @user = current_user
    @post.destroy
    flash[:success] = "Post Deleted Successfully!"
    respond_to do |format|
      format.html { redirect_after_destroy_back_or(@user) }
      format.js
    end
  end

  def report
    if request.get?
      respond_to do |format|
        format.html
        format.js
      end
    else
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
  end

  def edit
    @user = current_user
    @title = "Edit post"
    init_college_menu
    add_breadcrumbs
    render 'posts/edit'
  end

  def update
    if @post.update_attributes(params[@post.type.downcase])
      redirect_to user_path(current_user), :flash => {:success => "Post updated."}
    else
      @title = "Edit post"
      render 'edit'
    end
  end

  def vote_up
    @user = current_user
    vote_check_for(@post)
    respond_to do |format|
      format.html { redirect_to "/colleges/#{@post.college_id}/#{@post.type.downcase}s", :flash => {:success => "Vote up successful."} }
      format.js
    end
  end

  def vote_down
    @user = current_user
    vote_check_against(@post)
    respond_to do |format|
      format.html { redirect_to "/colleges/#{@post.college_id}/#{@post.type.downcase}s", :flash => {:success => "Vote down successful."} }
      format.js
    end
  end

  def opengraph
  end

  def send_in_email
    @url = send_in_email_post_path(@post)
    send_as_smack
    @submit = 'SHARE BY EMAIL'
    @subject =  "#{current_user.first_name} #{current_user.last_name} wants to share this post from Campusmack.com."
    render :send_as_smack unless request.post?
  end

  def send_as_smack
    redirect_to @post and return if params[:commit] == 'CANCEL'
    @url ||= send_as_smack_post_path(@post)
    @contacts = current_user.contacts.all
    @groups = current_user.contact_groups.all
    @submit = 'SEND AS SMACK'
    @subject = if request.post? then params[:share][:subject] else "You just got SMACKED by " + current_user.first_name + " " + current_user.last_name end
    if request.post?
      title = params[:share][:subject]

      to = ""
      if (params[:share][:to].present?)
        to = params[:share][:to].split(",").map do |c_id|
          begin
            c = Contact.find(c_id)
            if c.user_id == current_user.id then c.email else next end
          rescue ActiveRecord::RecordNotFound
            c_id
          end
        end.join(",")
      end
      UserMailer.share_post(@post, current_user, title, to, params[:share][:message], params[:action] == 'send_as_smack').deliver
      flash[:success] = 'Successfully sent!'
      redirect_to method("#{@post.postable_type.downcase}_#{@post.type.downcase}_path").call(@post.postable, @post)
    end
  end

  protected

  def find_post
    @post = Post.find params[:id]
  end

  def find_parent
    @parent = College.where(:permalink => params[:college_id]).first if params[:college_id]
    @parent ||= Conference.where(:permalink => params[:conference_id]).first if params[:conference_id]
    @parent ||= @post.postable if @post
    @post_cls = self.class.to_s.underscore.gsub('_controller','')
  end

  def init_college_menu
    if @parent
      prefix = "#{@parent.class.to_s.downcase}_"
      @main_menu << [ :link, 'All', @parent, '' ]
    else
      prefix = ""
      @main_menu << [ :link, 'All', posts_path, '' ]
    end
    if @post_cls == 'smacks'
      @main_menu << [ :text, 'Smacks', '', 'active' ]
    else
      @main_menu << [ :link, 'Smacks', eval("#{prefix}smacks_path(@parent)"), '' ]
    end
    if @post_cls == 'redemptions'
      @main_menu << [ :text, 'Redemptions', '', 'active' ]
    else
      @main_menu << [ :link, 'Redemptions', eval("#{prefix}redemptions_path(@parent)"), '' ]
    end
  end

  def add_breadcrumbs
    if @parent.class.name == 'Conference'
      breadcrumbs.add @parent.name, conference_path(@parent)
    elsif @parent.class.name == 'College'
      breadcrumbs.add @parent.conference.name, conference_path(@parent.conference)
    end
    breadcrumbs.add @parent.name, college_path(@parent) if @parent.class.name == 'College'
    @main_menu.each do |x|
      breadcrumbs.add x[1], x[2] if x[1] == @post_cls.titleize
    end
    breadcrumbs.add @post_cls.gsub('_posts','').titleize if [ 'videos', 'photos', 'news_posts' ].include?(@post_cls)
    action = params[:action].dup
    return if action == 'index'
    if action
      action.gsub!(/new|create/, 'Add')
      action.gsub!(/edit|update/, 'Edit')
      action.gsub!('show', @post.title) unless @post.new_record?
      breadcrumbs.add action
    end

  end

end
