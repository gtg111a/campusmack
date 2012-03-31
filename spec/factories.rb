#By using the symbol ':user', we get Factory Girl to simulate the User model
Factory.define :user do |user|
  user.username { Faker::Internet.user_name }
  user.first_name { Faker::Name.name }
  user.last_name { Faker::Name.name }
  user.gender 'M'
  user.confirmed_at Time.now
  user.email { Faker::Internet.email }
  user.birthday { (14 + rand(40)).years.ago.to_date }
  user.affiliation { User::AFFILIATION_OPTIONS.sample }
  user.association :college
  user.password "password"
  user.password_confirmation { |x| x.password }
end

Factory.define :conference do |i|
  i.name { Faker::Name.name }
  i.division { Faker::Name.name }
end

Factory.define :delivery do |i|
  i.association :post
  i.association :user
  i.association :college
end

Factory.define :college do |i|
  i.name { Faker::Name.name }
  i.association :conference
end

Factory.define :contact_group, :class => ContactGroup do |i|
  i.association :user
  i.name { Faker::Name.name }
end

Factory.define :contact_groups_contact, :class => ContactGroupsContact do |i|
  i.association :contact
  i.association :contact_group
end

Factory.define :post do |i|
  i.title { Faker::Name.name }
  i.type "Smack"
end

Factory.define :smack do |i|
  i.title { Faker::Name.name }
  i.summary { Faker::Lorem.sentences.join(". ") }
  i.type "Smack"
  i.after_create {|s| Factory(:post, :postable => s, :type => "Smack" )}
end

Factory.define :contact, :class => Contact do |i|
  i.association :user
  i.email { Faker::Internet.email }
  i.name { Faker::Name.name }
end

Factory.define :comment do |i|
  i.title { Faker::Name.name }
  i.comment { Faker::Name.name }
  i.commentable_id 6
  i.commentable_type "post"
  i.association :user
  i.reports_count 0
end

Factory.define :article do |i|
  i.body { Faker::Name.name }
  i.association :post
end

Factory.define :maintenance do |i|
  i.task { Faker::Name.name }
end

Factory.define :news_post do |i|
  i.association :post
  i.url { Faker::Internet.domain_word }
end

Factory.define :photo do |i|
  i.association :post
  i.caption { Faker::Name.name }
end

Factory.define :reason do |i|
  i.reason { Faker::Name.name }
end