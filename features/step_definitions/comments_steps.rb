Given /^I have comment for "([^"]*)" with text "([^"]*)" created by "([^"]*)"$/ do |title, text, username|
  u = User.where(:username => username).first
  p = Post.where(:title => title).first
  p.comments.create!(:comment => text, :user_id => u.id)
end