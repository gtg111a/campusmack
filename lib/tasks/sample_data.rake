namespace :db do
  desc "Reset db"
  task :crush => :environment do
    Rake::Task['db:reset'].invoke
  end
end

namespace :db do
  desc "set up colleges"
  task :new => :environment do
    Rake::Task['db:reset'].invoke
    make_admin
    make_colleges
  end
end

namespace :db do
  desc "set up more colleges"
  task :make_colleges => :environment do
    make_colleges
  end
end


namespace :db do
  desc "Fill database with sample data"
  task :mopulate => :environment do
    Rake::Task['db:reset'].invoke
    make_colleges
    make_users
    make_content
  end
end

def make_colleges
  College.create!(:name => "University of Georgia", :conference => "SEC")
  College.create!(:name => "Georgia Tech", :conference => "ACC")
  College.create!(:name => "Clemson", :conference => "ACC")
  College.create!(:name => "University of Florida", :conference => "SEC")
  College.create!(:name => "University of Miami", :conference => "ACC")
  College.create!(:name => "Duke", :conference => "ACC")
  College.create!(:name => "Florida State", :conference => "ACC")
  College.create!(:name => "University of North Carolina", :conference => "ACC")
  College.create!(:name => "Boston College", :conference => "ACC")
  College.create!(:name => "Maryland", :conference => "ACC")
  College.create!(:name => "North Carolina State", :conference => "ACC")
  College.create!(:name => "Virginia", :conference => "ACC")
  College.create!(:name => "Virginia Tech", :conference => "ACC")
  College.create!(:name => "Wake Forest", :conference => "ACC")
  College.create!(:name => "Alabama", :conference => "SEC")
  College.create!(:name => "Arkansas", :conference => "SEC")
  College.create!(:name => "Auburn", :conference => "SEC")
  College.create!(:name => "Kentucky", :conference => "SEC")
  College.create!(:name => "LSU", :conference => "SEC")
  College.create!(:name => "Mississippi State", :conference => "SEC")
  College.create!(:name => "Ole Miss", :conference => "SEC")
  College.create!(:name => "South Carolina", :conference => "SEC")
  College.create!(:name => "Tennessee", :conference => "SEC")
  College.create!(:name => "Vanderbilt", :conference => "SEC")
  @colleges = College.all
end


def make_content
  @colleges.each do |college|
    5.times do |n|

      college.smacks.create!(
          :content_type => "Video",
          :title => "Tech Nerds Everywhere",
          :content => "http://www.youtube.com/watch?v=UaWXbqu5Bcs",
          :vote => n,
          :college_id => college.id)

      college.redemptions.create!(
          :content_type => "Video",
          :title => "Calvin Johnson Highlights",
          :content => "http://www.youtube.com/watch?v=YV_j7_CCc8A",
          :vote => n,
          :college_id => college.id)
    end
  end
end

def make_users
  admin = User.create!(:username => "@campusmack",
                       :first_name => "Campus",
                       :last_name => "Smack",
                       :email => "michael.bivone@gmail.com",
                       :password => "campusmack",
                       :password_confirmation => "campusmack")
  admin.toggle!(:admin)
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_admin
  admin = User.create!(:username => "@campusmack",
                       :first_name => "Campus",
                       :last_name => "Smack",
                       :college => "Georgia Tech",
                       :affiliation => "Alumni",
                       :email => "michael.bivone@gmail.com",
                       :password => "campusmack",
                       :password_confirmation => "campusmack"
  )
  admin.toggle!(:admin)
  admin.confirm!
end

def make_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      content = Faker::Lorem.sentence(5)
      user.microposts.create!(:content => content)
    end
  end
end

def make_relationships
  users = User.all
  user = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end