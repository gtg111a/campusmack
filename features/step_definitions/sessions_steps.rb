Given /^I have "([^"]*)" college in "([^"]*)"$/ do |college, conference|
  c = Conference.create!(:name => conference, :division => 'I-A') unless c = Conference.where(:name => conference).first
  c.colleges.create!(:name => college) unless c.colleges.where(:name => college).any?
end

Given /^I am not authenticated$/ do
  visit sign_out_path
end

Given /^I have confirmed (Male|Female) user "([^\"]*)" "([^\"]*)" with username "([^\"]*)", email "([^\"]*)", password "([^\"]*)", college "([^\"]*)" and affiliation "([^\"]*)"$/ do |gender, first_name, last_name, username, email, password, college, affiliation|
  Given %Q{I have \"#{college}\" college in "SEC"} unless College.where(:name => college).any?
  u.destroy if u = User.where(:email => email).first
  u = User.new(:email => email,
           :password => password,
           :password_confirmation => password,
           :first_name => first_name,
           :last_name => last_name,
           :username => username,
           :gender => gender[0..0],
           :college_id => College.where(:name => college).first.id,
           :affiliation => affiliation)
  u.confirm!
  u.save!
end

Given /^user signed in as "([^"]*)" with "([^"]*)"$/ do |email, password|
  visit sign_out_path
  unless email.blank?
    visit sign_in_path
    fill_in "Email", :with => email
    fill_in "Password", :with => password
    click_button "SIGN IN"
    page.should have_content("Signed in successfully")
  end
end