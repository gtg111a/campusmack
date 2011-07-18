class SmacksController < ApplicationController
  
  def new
    @smack = Smack.new
  end
  
  def create
    @smack = Smack.new
  end
  
=begin  def index
    @smacks = Smack.all
  end
  
  def show
    @smack = College.find(params[:id])
    @title = @college.name
  end
=end  
  def index
    @college = College.find(params[:college_id])
    @title = "All smacks from #{@college.name}"
    @smacks = @college.smacks.paginate(:page => params[:page])
  end
  
  def show
    @smack = College.find(params[:id])
    @title = @college.name
    @smacks = @college.smacks.paginate(:page => params[:page])
  end
  
end
