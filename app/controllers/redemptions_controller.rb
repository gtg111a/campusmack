class RedemptionsController < ApplicationController
  
    def new
      @redemption = redemption.new
    end

    def create
      @redemption = redemption.new
    end
     
    def index
      @college = College.find(params[:college_id])
      @title = "All redemptions from #{@college.name}"
      @redemptions = @college.redemptions.paginate(:page => params[:page])
    end

    def show
      @redemption = College.find(params[:id])
      @title = @college.name
      @redemptions = @college.redemptions.paginate(:page => params[:page])
    end

  end
