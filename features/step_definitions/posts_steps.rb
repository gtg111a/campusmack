Given /^I have "([^"]*)" (conference|college) (Smack|Redemption) "([^"]*)" with text "([^"]*)" created by "([^"]*)"$/ do |name, confcoll, type, title, text, username|
  u = User.where(:username => username).first
  if confcoll == "conference"
    c = Conference.where(:name => name).first
  else
    c = College.where(:name => name).first
  end
  if type == "Smack"
    smack = c.smacks.build(:title => title,
    :summary => text)
    smack.user_id = u.id
    smack.save!
  else
    red = c.redemptions.build(:title => title,
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
    Given %Q{I have confirmed Male user "#{hash["First Name"]}" "#{hash["Last Name"]}" with username "#{hash["Username"]}", email "#{hash["Email"]}", password "#{hash["Password"]}", college "#{hash["College"]}" and affiliation "#{hash["Affiliation"]}"}
  end
end

Given /^I have reasons$/ do |table|
  table.raw.each do |row|
    Reason.find_or_create_by_reason(row[0])
  end
end

Then /^I should have report for "([^"]*)" from "([^"]*)" with reason "([^"]*)" and custom reason "([^"]*)"$/ do |title, email, reason, custom_reason|
  p = Post.find_by_title!(title)
  u = User.find_by_email!(email)
  if reason.blank?
    s = p.reports.where(:user_id => u.id)
  else
    r = Reason.find_by_reason!(reason)
    s = p.reports.where(:user_id => u.id, :reason_id => r.id)
  end
  s.where(:custom_reason => custom_reason) unless custom_reason.blank?
  s.any?.should be_true
end