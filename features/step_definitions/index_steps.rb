Given /^I have colleges$/ do |table|
  table.hashes.each do |hash|
    Given %Q{I have "#{hash["College"]}" college in "#{hash["Conference"]}"}
  end
end

Given /^I have conferences$/ do |table|
  table.hashes.each do |hash|
    Conference.create(:name => hash["Conference"]) unless Conference.where(:name => hash["Conference"]).any?
  end
end


Given /^I have posts$/ do |table|
  table.hashes.each do |hash|
    c = College.where(:name => hash["College"]).first unless hash["College"].blank?
    c = Conference.where(:name => hash["Conference"]).first unless hash["Conference"].blank?
    u = User.where(:username => hash["Username"]).first
    post = c.posts.build(:title => hash["Title"], :summary => "bla-bla")
    post.type = hash["Type"]
    post.user = u
    case hash["Kind"]
    when "Video"
      post.build_video(:url => "http://www.youtube.com/watch?v=YV_j7_CCc8A")
    when "Photo"
      post.build_photo(:caption => "Caption", :image_file_name => "Enjoy the Silence (Lcdbong18).png", :image_content_type => "image/png", :image_file_size => 506606)
    when "News"
      post.build_news_post(:url => "http://www.ya.ru")
    when "Stats"
      post.build_statistic(:name => "Name", :data => "Data")
    end
    if hash["Week"]
      post.on_frontpage_week = if hash["Week"] == "current" then Date.today.cweek else hash["Week"] end
    end
    post.created_at = Time.now + hash["Created"].to_i if hash["Created"]
    post.up_votes = hash["Votes Up"] if hash["Votes Up"]
    post.down_votes = hash["Votes Down"] if hash["Votes Down"]
    post.save!
  end
end

Then /^(?:|I )should see a link to "([^"]*)" conference status$/ do |conf|
  c = Conference.find_by_name(conf)
  find("a[href=\"#{status_conference_path(c)}\"]")
end