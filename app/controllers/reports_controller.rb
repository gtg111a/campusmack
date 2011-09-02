class ReportsController < ApplicationController

  def index
    authorize! :manage, :all
    @posts = Post.where('report_count IS NOT NULL').order('report_count DESC').paginate(:page => params[:page])
  end

end
