namespace :db do 
   desc "Reset db" 
   task :crush => :environment do
     Rake::Task['db:reset'].invoke 
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
    College.create!(:name => "University of Georgia")
    College.create!(:name => "Georgia Tech")
    College.create!(:name => "Clemson")
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
  admin = User.create!(:name => "Example User",
               :email => "example@railstutorial.org", 
               :password => "foobar", 
               :password_confirmation => "foobar",)
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