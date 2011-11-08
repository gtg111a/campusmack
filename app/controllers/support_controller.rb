class SupportController < ApplicationController
  skip_authorization_check

  def new
    # id is required to deal with form
    @support = Support.new(:id => 1)
    breadcrumbs.add 'Contact Us'
  end

  def create
    @support = Support.new(params[:support])
    if @support.save
      redirect_to root_path, :flash => {:success => "Message Sent!"}
    else
      flash[:alert] = "You must fill in all fields."
      render :new
    end
  end

end


