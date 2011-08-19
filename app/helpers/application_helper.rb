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
    fixed_provider_name = provider.to_s.gsub('_apps','')
    provider_name = fixed_provider_name.titleize
    html = ''
    html << "<a href=#{omniauth_authorize_path(resource_name, provider)}>" if link
    html << image_tag(fixed_provider_name + '_' + size.to_s + '.png', :alt => provider_name)
    html << provider_name + '</a>' if link
    raw(html)
  end

end