module SessionsHelper


  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  def redirect_after_destroy_back_or(default)
    if session[:return_to] =~ /(colleges|conferences)\/[^\/]+\/(smacks|redemptions|article_posts)\/\d+/
      redirect_to default
    else
      redirect_to(session[:return_to] || default)
    end
    clear_return_to
  end

  def store_location_edit
    if request.get?
      @url = request.fullpath
    end
  end

  def store_location
    unless request.fullpath =~ /\/posts/
    session[:return_to] = request.fullpath
    end
  end
   
  def clear_return_to 
    session[:return_to] = nil
  end

end


