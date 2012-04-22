FactoryGirl.define do
  factory :user do |user|
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

  factory :admin, :parent => :user do |user|
    user.role 'admin'
  end

  factory :conference do |i|
    i.name { Faker::Name.name }
    i.division { Faker::Name.name }
  end

  factory :delivery do |i|
    i.association :post
    i.association :user
    i.association :college
  end

  factory :college do |i|
    i.name { Faker::Name.name }
    i.association :conference
  end

  factory :contact_group, :class => ContactGroup do |i|
    i.association :user
    i.name { Faker::Name.name }
  end

  factory :contact_groups_contact, :class => ContactGroupsContact do |i|
    i.association :contact
    i.association :contact_group
  end

  factory :post do |i|
    i.title { Faker::Name.name }
    i.type "Smack"
  end

  factory :smack do |i|
    i.title { Faker::Name.name }
    i.summary { Faker::Lorem.sentences.join(". ") }
    i.type "Smack"
  end

  factory :redemption do |i|
    i.title { Faker::Name.name }
    i.summary { Faker::Lorem.sentences.join(". ") }
  end

  factory :article_post do |i|
    i.title { Faker::Name.name }
    i.summary { Faker::Lorem.sentences.join(". ") }
    i.association :article
  end

  factory :contact, :class => Contact do |i|
    i.association :user
    i.email { Faker::Internet.email }
    i.name { Faker::Name.name }
  end

  factory :comment do |i|
    i.title { Faker::Name.name }
    i.comment { Faker::Name.name }
    i.commentable_id 6
    i.commentable_type "post"
    i.association :user
    i.reports_count 0
  end

  factory :article do |i|
    i.body { Faker::Name.name }
    i.association :post
  end

  factory :maintenance do |i|
    i.task { Faker::Name.name }
  end

  factory :news_post do |i|
    i.association :post
    i.url { Faker::Internet.domain_word }
  end

  factory :photo do |i|
    i.association :post
    i.caption { Faker::Name.name }
  end

  factory :reason do |i|
    i.reason { Faker::Name.name }
  end
end
