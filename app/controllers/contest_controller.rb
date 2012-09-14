class ContestController < ApplicationController

  def index
    @title = "Contest"
    posts = Post.joins(:video)
    @search = posts.search(params[:search]).where("contest = ?", true)
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
        add_breadcrumbs

        # We use the views from the posts folder for everything
        render 'posts/index'
      end
    end
  end

end
