class ContestController < ApplicationController

  def index
    @title = "Contest"
    posts = Post.joins(:video)
    @search = posts.search(params[:search]).where("contest = ?", true)
    @order = params[:order] || Post::default_order
    @per_page = params[:per] || Post::PER_PAGE_DEFAULT[0]
    @posts = @search.paginate(:page => params[:page], :order => @order, :per_page => @per_page)
    #init_college_menu
    add_breadcrumbs

    # We use the views from the posts folder for everything
    render 'posts/index'
  end

end
