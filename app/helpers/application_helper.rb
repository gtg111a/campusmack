module ApplicationHelper
  #Return a title on a per-page basis
  def close_facebox()
    return "jQuery.facebox.close();".html_safe
  end

  def mark_required(object, attribute)
    raw "<span class='required_sign'>*</span>" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
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

  def sign_up_service_link(provider, size = 64, link = true, image = true)
    resource_name ||= :user
    fixed_provider_name = provider.to_s.gsub('_apps', '')
    provider_name = fixed_provider_name.titleize
    html = ''
    html << "<li class='#{fixed_provider_name}'>"
    html << "<a href='#{omniauth_authorize_path(resource_name, provider)}' class='#{' icon' if size == :icon} clearfix'>" if link
    html << "<span class='symbol'>#{image_tag(fixed_provider_name + '_symbol_button' + '.png', :alt => provider_name)}</span>" if image
    html << "<span class='invitation'>Sign up with #{fixed_provider_name.capitalize}</span>"
    html << '</a>'
    html << '</li>' if link
    raw(html)
  end

  def header_service_link(provider)
    service_link(provider, :icon, true, false)
  end

  def user_nav
    #@user_nav << ['Help', help_path]
    @user_nav << ['HOME', '/']
    @user_nav << ['CONTACT', '/contact-us', [:class => :big]]
    @user_nav << ['ABOUT', '/about']
    if signed_in?
      @user_nav << ['SIGN OUT', sign_out_path, [:class => :big]]
    else
      #@user_nav << ['Create Account', sign_up_path]
      @user_nav << ['SIGN IN', sign_in_path]
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
    meta_hash.each_pair do |key, value|
      meta_text << "<meta property=\"#{key}\" content=\"#{value.html_safe}\" />
      "
    end
    content_for :og_meta do
      meta_text.html_safe
    end
  end

  def meta_tags(meta_hash)
    meta_text = ""
    meta_hash.each_pair do |key, value|
      meta_text << "<meta name=\"#{key}\" content=\"#{value.html_safe}\" />
      "
    end
    content_for :og_meta do
      meta_text.html_safe
    end
  end

  def censored_text(original_text)
    if (current_user.present? && current_user.censor_text?)
      original_text.present? ? original_text.censored : ""
    else
      return original_text
    end
  end

  def render_breadcrumbs
    return if params[:controller]['registrations'] || params[:controller]['sessions'] || params[:controller] == 'welcome'
    raw('<div class="breadcrumbs">'+breadcrumbs.render(:format => :inline, :separator => '>')+'</div>')
  end

  def gravatar_for(user, options = {:size => 50})
    gravatar_image_tag(user.email.downcase, :alt => user.username,
                       :class => 'gravatar',
                       :gravatar => options)
  end

  def get_toast_type(flash)
    case flash
      when 'success', 'warning', 'error', 'notice'
        flash
      when 'alert'
        'warning'
      when 'info'
        'notice'
      else
        'notice'
    end
  end

  def get_toast_sticky(flash)
    case get_toast_type(flash)
      when 'success'
        true
      when 'warning'
        true
      when 'error'
        true
      when 'notice'
        false
      else
        false
    end
  end
end