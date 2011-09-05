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
    make_colleges
    make_admin
  end
end

namespace :db do
  desc "set up more colleges"
  task :make_colleges => :environment do
    make_colleges
  end
end


namespace :db do
  desc "add sample content"
  task :add_content => :environment do
    make_content
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
  sec = Conference.create!(:name => 'SEC')
  acc = Conference.create!(:name => 'ACC')
  [ "Alabama", "Arkansas", "Auburn", "Florida", "Georgia", "Kentucky", "LSU",
    "Mississippi State", "Ole Miss", "South Carolina", "Tennessee", "Vanderbilt" ].each do |college|
    sec.colleges.create!(:name => college)
  end

  [ "Boston College", "Clemson", "Duke", "Florida State", "Georgia Tech", "Maryland",
    "Miami", "North Carolina", "North Carolina State", "Virginia", "Virginia Tech",
    "Wake Forest" ].each do |college|
    acc.colleges.create!(:name => college)
  end
  puts "Added #{College.count} colleges"
end


def make_content
  College.all.each do |college|
    5.times do |n|
      smack = college.smacks.create!(:title => "Tech Nerds Everywhere")
      smack.create_video(:url => "http://www.youtube.com/watch?v=UaWXbqu5Bcs")
      redemption = college.redemptions.create!(:title => "Calvin Johnson Highlights")
      redemption.create_video(:url => "http://www.youtube.com/watch?v=YV_j7_CCc8A")
    end
  end
end

def make_users
  make_admin
  5.times { |n| Factory(:user) }
end

def make_admin
  admin = Factory(:user, :username => '@campusmack', :password => 'campusmack', :email => 'test@campusmack.com', :admin => true)
  admin.confirm!
  puts "Added admin"
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