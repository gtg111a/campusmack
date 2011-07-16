class CollegesController < ApplicationController
  
  def new
    @college = College.new
  end
  
  def create
    @college = College.new(:name)
  end
  
  def index
    @colleges = College.all
  end
  
  def show_college
    puts "hi"
  end
    
  def gtsmack
    @title = "GT Smack"
  end
  
  def gtredemption
    @title = "GT Redemption"
  end
  
  def gthome
    @title = "GT Home"
  end
  
end
