class BlogsController < ApplicationController
  authorize_resource
  
  before_filter :find_blog, :only => [:show]
    
    def new
      @blog = Blog.new
    end

    def create
      @blog = Blog.new(:name)
    end

    def index
      @blogs = Blog.all
    end
    
    def show
      @parent = @blog
      breadcrumbs.add @blog.name
      @order = params[:order] || 'created_at desc'
      @search = @blog.posts.search(params[:search])
      @title = "Campusmack " + @blog.name
      if params[:search]
        @posts = @search.paginate(:page => params[:page], :order => @order)
      else
        @posts = find_posts(@blog)
      end
    end
    
  private
  
  def find_blog
       @blog = Blog.where(:permalink => params[:id]).first
   end
   
   def find_posts(blog)
      blog.posts.paginate(:page => params[:page], :order => @order)
    end
    
end
