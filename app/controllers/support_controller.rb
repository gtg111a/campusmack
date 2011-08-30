class SupportController < ApplicationController
<<<<<<< HEAD
  skip_authorization_check

    def new
      # id is required to deal with form
      @support = Support.new(:id => 1)
    end
=======
  skip_authorization_check :only => [:new, :create]
  load_and_authorize_resource
>>>>>>> b79f58bb0cdc89a0ad3d39eb72adeecf4d520801

  def new
    # id is required to deal with form
    @support = Support.new(:id => 1)
  end

  def create
    @support = Support.new(params[:support])
    if @support.save
      redirect_to root_path, :flash => {:success => "Message Sent!"}
    else
      flash[:alert] = "You must fill all fields."
      render 'new'
    end
  end

end
  

