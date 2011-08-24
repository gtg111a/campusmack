#By using the symbol ':user', we get Factory Girl to simulate the User model
Factory.define :user do |user|
  user.username { Faker::Internet.user_name }
  user.first_name { Faker::Name.name }
  user.last_name { Faker::Name.name }
  user.email { Faker::Internet.email }
  user.affiliation 'Student'
  user.college { College.all.sample }
  user.password "foobar"
  user.password_confirmation { |x| x.password }
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end

Factory.sequence :content do |n|
  "POOOFACE"
end
