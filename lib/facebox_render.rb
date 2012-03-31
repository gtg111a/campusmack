module FaceboxRender
  include ActionView::Helpers::JavaScriptHelper
  
  def render_to_facebox( options = {} )
    l = options.delete(:layout) { false }
    
    if options[:action]
      s = render_to_string(:action => options[:action], :layout => l)
    elsif options[:template]
      s = render_to_string(:template => options[:template], :layout => l)
    elsif !options[:partial] && !options[:html]
      s = render_to_string(:layout => l)
    end
    
    script_string = ''

    if options[:action]
      script_string << "jQuery.facebox(#{s.to_json});"
    elsif options[:template]
      script_string << "jQuery.facebox(#{s.to_json});"
    elsif options[:partial]
      script_string << "jQuery.facebox(#{(render :partial => options[:partial]).to_json});"
    elsif options[:html]
      script_string << "jQuery.facebox(#{options[:html].to_json});"
    else
      script_string << "jQuery.facebox('#{escape_javascript s}');"
    end

    if options[:msg]
      script_string << "jQuery('#facebox .content').prepend('<div class=\"message\">#{options[:msg]}</div>');"
    end

    render :text => script_string
  end
  
  # close an existed facebox, you can pass a block to update some messages
  def close_facebox
    render :update do |page|
      page << "jQuery.facebox.close();"
      yield(page) if block_given?
    end
  end

  # redirect_to other_path (i.e. reload page)
  def redirect_from_facebox(url)
    render :update do |page|
      page.redirect_to url
    end
  end
  
  # redirect to another facebox page
  def redirect_to_facebox(url)
    render :update do |page|
      page << "$.getScript('#{url}')"
    end
  end
  
end
