Given /^I have (Smack|Redemption) "([^"]*)" with text "([^"]*)" created by "([^"]*)"$/ do |type, title, text, username|
  u = User.where(:username => username).first
  college = u.college
  if type == "Smack"
    smack = college.smacks.build(:title => title,
    :summary => text)
    smack.user_id = u.id
    smack.save!
  else
    red = college.redemptions.build(:title => title,
    :post_summary => text)
    red.user_id = u.id
    red.save!
  end
end

Given /^(Smack|Redemption) "([^"]*)" vote (up|down) count is (\d+)$/ do |type, title, dir, count|
  if type == "Smack"
    pid = Smack.where(:title => title).first.id
  else
    pid = Redemption.where(:title => title).first.id
  end
  find("#vote_count_#{dir}#{pid}").should have_content(count)
end

Then /^(Smack|Redemption) "([^"]*)" vote (up|down) count should be (\d+)$/ do |type, title, dir, count|
  if type == "Smack"
    pid = Smack.where(:title => title).first.id
  else
    pid = Redemption.where(:title => title).first.id
  end
  find("#vote_count_#{dir}#{pid}").should have_content(count)
end

When /^I press Vote Up button$/ do
  find("a.vote-up").click
end

When /^I press Vote Down button$/ do
  find("a.vote-down").click
end

Given /^I have confirmed users$/ do |table|
  table.hashes.each do |hash|
    Given %Q{I have confirmed user "#{hash["First Name"]}" "#{hash["Last Name"]}" with username "#{hash["Username"]}", email "#{hash["Email"]}", password "#{hash["Password"]}", college "#{hash["College"]}" and affiliation "#{hash["Affiliation"]}"}
  end
end