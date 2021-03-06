class ArticlePostsController < ApplicationController
  authorize_resource
  before_filter :find_post, :except => [ :new, :create, :index ]
  before_filter :find_parent, :except => [ :send_as_smack, :send_in_email ]

  def new
    @post = @parent.send(@post_cls).build
    @title = 'Submit a ' + @parent.name + ' article'
    @submit = 'FILL IN THE FOLLOWING TO SUBMIT AN ARTICLE'
    init_college_menu if !@parent.is_a?(Blog)
    add_breadcrumbs
  end

  def create
    @post = @parent.send(@post_cls).build(params[@post_cls.singularize])
    @post.user = current_user
    # overwrites the default true value of published which is required for the other
    # type of posts
    @post.published = params[@post_cls.singularize][:published].to_i > 0
    init_college_menu if !@parent.is_a?(Blog)
    if @post.save
      if store_location =~ /^\/conferences\//
        redirect_to conference_path(@parent)
      else
        redirect_to store_location, :flash => {:success => "#{@parent.name} Article Submitted Successfully!"}
      end
    end
  end

  def index
   if @parent
    if @parent.is_a?(User)
    @title = @parent.first_name + " Articles"
    else
    @title = @parent.name + " Articles"
    end
    posts = if can? :manage, :all
    @parent.send(@post_cls)
    else
      @parent.send(@post_cls).published
    end
  else
      @title = "All Articles"
      posts = Post.published.where(:type => 'ArticlePost')
  end  
    @search = posts.search(params[:search])
    @order = params[:order] || Post::default_order
    @per_page = params[:per] || Post::PER_PAGE_DEFAULT[0]
    @posts = @search.paginate(:page => params[:page], :order => @order, :per_page => @per_page)

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
        init_college_menu if !@parent.is_a?(Blog)
        add_breadcrumbs

        # We use the views from the posts folder for everything
        render 'posts/index'
      end
    end
  end

  def show
    redirect_to polymorphic_path([ @parent, :articles ]) and return unless @post
    @youtube_video = VideoInfo.new(@post.article.video_url) if @post && @post.article && !@post.article.video_url.blank?
    @post.censored_text(@post.title, current_user)
    @post.censored_text(@post.summary,current_user)
    @comments = Comment.find(:all, :conditions => {:commentable_id => @post.id}).paginate(:page => params[:page], :order => 'created_at DESC')
    @title = "#{@parent.name} #{@post.class.to_s.titleize}"
    @page_description = "Funny " + @post.postable.name + " news. " + @post.title
    init_college_menu if !@parent.is_a?(Blog)
    add_breadcrumbs
    render 'posts/show'
  end

  def destroy
    @user = current_user
    @post.destroy
    flash[:success] = "Post Deleted Successfully!"
    respond_to do |format|
      format.html { redirect_to(@user) }
      format.js
    end
  end

  def edit
    @user = current_user
    @title = "Edit post"
    init_college_menu if !@parent.is_a?(Blog)
    add_breadcrumbs
    render 'posts/edit'
  end

  def update
    if @post.update_attributes(params[@post.type.to_s.underscore])
      redirect_to user_path(current_user), :flash => {:success => "Post updated."}
    else
      @title = "Edit post"
      render :edit
    end
  end

  protected

  def find_post
    if current_user.try(:role) == 'admin'
      @post = Post.find(:first, :conditions => { :permalink => params[:id]} )
      return
    end
    begin
      @post = Post.published.find(:first, :conditions => { :permalink => params[:id]} )
    rescue
    end
    @articlepost = @post
  end

  def find_parent
    @parent = College.where(:permalink => params[:college_id]).first if params[:college_id]
    @parent ||= Conference.where(:permalink => params[:conference_id]).first if params[:conference_id]
    @parent ||= User.where(:id => params[:user_id]).first if params[:user_id]
    @parent ||= Blog.where(:permalink => params[:blog_id]).first if params[:blog_id]
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
end
