#By using the symbol ':user', we get Factory Girl to simulate the User model
Factory.define :user do |user|
  user.username { Faker::Internet.user_name }
  user.first_name { Faker::Name.name }
  user.last_name { Faker::Name.name }
  user.email { Faker::Internet.email }
  user.affiliation 'Student'
  user.association :college
  user.password "password"
  user.password_confirmation { |x| x.password }
end

Factory.define :college do |i|
  i.name { Faker::Name.name }
end

Factory.define :contact_group, :class => ContactGroup do |i|
  i.association :user
  i.name { Faker::Name.name }
end

Factory.define :contact, :class => Contact do |i|
  i.association :user
  i.email { Faker::Internet.email }
  i.name { Faker::Name.name }
end