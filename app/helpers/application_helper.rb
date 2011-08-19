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

  def service_link(provider)
    fixed_provider_name = provider.to_s.gsub('_apps','')
    provider_name = fixed_provider_name.titleize
    link_to(omniauth_authorize_path(resource_name, provider)) do
      image_tag(fixed_provider_name + '_64.png', :alt => provider_name) + provider_name
    end
  end
end