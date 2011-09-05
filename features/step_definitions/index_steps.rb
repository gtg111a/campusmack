Given /^I have colleges$/ do |table|
  table.hashes.each do |hash|
    Given %Q{I have "#{hash["College"]}" college in "#{hash["Conference"]}"}
  end
end

Given /^I have posts$/ do |table|
  table.hashes.each do |hash|
    c = College.where(:name => hash["College"]).first
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
    post.save!
  end
end