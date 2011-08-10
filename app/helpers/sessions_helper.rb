module SessionsHelper


  def redirect_back_or(default) 
    redirect_to(session[:return_to] || default) 
    clear_return_to
  end
  
  def store_location_edit
    if request.get?
      @url = request.fullpath
    end
  end

  def store_location
    unless request.fullpath =~ /posts/
    session[:return_to] = request.fullpath
    end
  end
   
  def clear_return_to 
    session[:return_to] = nil
  end

end


