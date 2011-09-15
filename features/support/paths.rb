module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^signup page$/
      sign_up_path

    when /^root page$/
      root_path

    when /"([^\"]*)" user page/
      u = User.where(:username => $1).first
      user_path(u)

    when /"([^\"]*)" user smacks page/
      u = User.where(:username => $1).first
      smacks_user_path(u)

    when /"([^\"]*)" user redemptions page/
      u = User.where(:username => $1).first
      redemptions_user_path(u)

    when /^"([^\"]*)" comment edit page/
      c = Comment.where(:comment => $1).first
      edit_comment_path(c)

    when /^Smack "([^\"]*)" page/
      smack = Smack.where(:title => $1).first
      if smack.postable_type == "College"
        "/colleges/#{smack.postable.permalink}/smacks/#{smack.id}"
      else
        "/conferences/#{smack.postable.name}/smacks/#{smack.id}"
      end

    when /^Redemption "([^\"]*)" page/
      red = Redemption.where(:title => $1).first
      if red.postable_type == "College"
        "/colleges/#{red.postable.permalink}/redemptions/#{red.id}"
      else
        "/conferences/#{red.postable.name}/redemptions/#{red.id}"
      end

    when /^Smack "([^\"]*)" edit page/
      smack = Smack.where(:title => $1).first
      if smack.postable_type == "College"
        "/colleges/#{smack.postable.permalink}/smacks/#{smack.id}/edit"
      else
        "/conferences/#{smack.postable.name}/smacks/#{smack.id}/edit"
      end

    when /^Redemption "([^\"]*)" edit page/
      red = Redemption.where(:title => $1).first
      if red.postable_type == "College"
        "/colleges/#{red.postable.permalink}/redemptions/#{red.id}/edit"
      else
        "/conferences/#{red.postable.name}/redemptions/#{red.id}/edit"
      end
    
    when /^"([^\"]*)" college page/
      c = College.where(:name => $1).first
      "/colleges/#{c.permalink}"

    when /^"([^\"]*)" college ([^\s]+) page/
      c = College.where(:name => $1).first
      "/colleges/#{c.permalink}/#{$2}"

    when /^"([^\"]*)" conference page/
      "/conferences/#{$1.parameterize}"

    when /^"([^\"]*)" conference ([^\s]+) page/
      "/conferences/#{$1.parameterize}/#{$2}"
    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
