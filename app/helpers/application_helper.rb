module ApplicationHelper
  #Return a title on a per-page basis
  def logo
    image_tag("Smack That", :class => "round")
  end

  def title
    base_title = "Campus Smack"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def service_link(provider, size = 64, link = true)
    resource_name ||= :user
    fixed_provider_name = provider.to_s.gsub('_apps', '')
    provider_name = fixed_provider_name.titleize
    html = ''
    html << "<a href=#{omniauth_authorize_path(resource_name, provider)}>" if link
    html << image_tag(fixed_provider_name + '_' + size.to_s + '.png', :alt => provider_name)
    html << '</a>' if link
    raw(html)
  end

  def user_nav
    if signed_in?
      @user_nav << [ 'My Posts', user_path(current_user) ]
      @user_nav << [ 'Edit Profile', edit_user_registration_path(current_user) ]
      @user_nav << [ 'Sign out', sign_out_path, [ :method => :delete ] ]
    else
      @user_nav << ['Create Account', sign_up_path]
      @user_nav << ['Sign In', sign_in_path]
    end
    html = '<div class="account-wrapper"><ul id="user-account-nav">'
    @user_nav.each do |text, link, other|
      html << '<li>' + link_to(text, link, *other) + '</li>'
    end
    raw(html + '</ul></div>')
  end

  def main_nav
    return if @main_menu.empty?
    html = '<nav role="navigation" class="clearfix"><ul class="main-nav">'
    @main_menu.each do |text, link, other|
      html << '<li>' + link_to(text, link, *other) + '</li>'
    end
    raw(html + '</ul></nav>')
  end

end