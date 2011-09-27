module ApplicationHelper
  #Return a title on a per-page basis
  def close_facebox()
    return "jQuery.facebox.close();".html_safe
  end
  
  def logo
    image_tag("Smack That", :class => "round")
  end

  def title
    base_title = "Campusmack"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def service_link(provider, size = 64, link = true, image = true)
    resource_name ||= :user
    fixed_provider_name = provider.to_s.gsub('_apps', '')
    provider_name = fixed_provider_name.titleize
    html = ''
    html << "<a href='#{omniauth_authorize_path(resource_name, provider)}' class='#{provider}#{' icon' if size == :icon}'>" if link
    html << image_tag(fixed_provider_name + '_' + size.to_s + '.png', :alt => provider_name) if image
    html << '</a>' if link
    raw(html)
  end

  def header_service_link(provider)
    service_link(provider, :icon, true, false)
  end

  def user_nav
    #@user_nav << ['Help', help_path]
    @user_nav << ['HOME', '/']
    @user_nav << ['CONTACT', '/contact-us', [ :class => :big]]
    @user_nav << ['ABOUT', '/about']
    if signed_in?
      #@user_nav << ['My Posts', user_path(current_user)]
      #@user_nav << ['Edit Profile', edit_user_registration_path(current_user)]
      @user_nav << ['SIGN OUT', sign_out_path, [ :class => :big]]
    else
      #@user_nav << ['Create Account', sign_up_path]
      @user_nav << ['SIGN IN', sign_in_path ]
    end
    html = '<div class="menu">'
    html << '<ul>'
    @user_nav.each do |text, link, other|
      html << '<li>' + link_to(text, link, *other) + '</li>'
    end
    #html << '<li id="alt_serv">Signed in with' + service_link(Authentication.where(:id => session[:provider]).first, 32, false) + '</li>' if signed_in? && session[:provider]
    raw(html + '</ul></div>')
  end

  def main_nav
    return if @main_menu.empty?
    html = '<div role="navigation" class="clearfix"><ul class="main-nav">'
    @main_menu.each do |text, link, other|
      html << '<li>' + link_to(text, link, *other) + '</li>'
    end
    raw(html + '</ul></div>')
  end

  def open_graph_meta_tags(meta_hash)
    meta_text = ""
    meta_hash.each_pair do |key,value|
      meta_text << "<meta property=\"#{key}\" content=\"#{value.html_safe}\" />
      "
    end
    content_for :og_meta do
      meta_text.html_safe
    end
  end

  def meta_tags(meta_hash)
    meta_text = ""
    meta_hash.each_pair do |key,value|
      meta_text << "<meta name=\"#{key}\" content=\"#{value.html_safe}\" />
      "
    end
    content_for :og_meta do
      meta_text.html_safe
    end
  end

  def breadcrumbs
    return if params[:controller] == 'welcome'
    %Q{<div class="breadcrumbs">
    <a href="#">Home</a> &gt;
    <a href="#">Breadcrumb</a> &gt;
    <b class="actual">Actual page</b>
    </div>}.html_safe
  end

end