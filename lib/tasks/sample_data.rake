require "ffaker"
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

namespace :create do
  desc "create dummy contacts list"
  task :contacts_csv => :environment do
    File.open(Rails.root + 'outlook_contacts.csv', 'w') do |f|
      f.puts "First Name,Middle Name,Last Name,Title,Suffix,Initials,Web Page,Gender,Birthday,Anniversary,Location,Language,Internet Free Busy,Notes,E-mail Address,E-mail 2 Address,E-mail 3 Address,Primary Phone,Home Phone,Home Phone 2,Mobile Phone,Pager,Home Fax,Home Address,Home Street,Home Street 2,Home Street 3,Home Address PO Box,Home City,Home State,Home Postal Code,Home Country,Spouse,Children,Manager's Name,Assistant's Name,Referred By,Company Main Phone,Business Phone,Business Phone 2,Business Fax,Assistant's Phone,Company,Job Title,Department,Office Location,Organizational ID Number,Profession,Account,Business Address,Business Street,Business Street2,Business Street 3,Business Address PO Box,Business City,Business State,Business Postal Code,Business Country,Other Phone,Other Fax,Other Address,Other Street,Other Street 2,Other Street 3,Other Address PO Box,Other City,Other State,Other Postal Code,Other Country,Callback,Car Phone,ISDN,Radio Phone,TTY/TDD Phone,Telex,User 1,User 2,User 3,User 4,Keywords,Mileage,Hobby,Billing Information,Directory Server,Sensitivity,Priority,Private,Categories"
      400.times do
        f.puts "#{Faker::Name.first_name},,#{Faker::Name.last_name},,,,,,,,,,,,#{Faker::Internet.email},,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Normal,,My Contacts,"
      end
    end
    puts "outlook_contacts.csv has been created."
  end
end

def make_colleges
  {
    'I-A' => {
      'ACC' => [
        ['Boston College', 'BC'],
        ['Clemson', 'CLEM'],
        ['Duke', 'DUKE'],
        ['Florida State', 'FSU'],
        ['Georgia Tech', 'GT'],
        ['Maryland', 'MD'],
        ['Miami (FL)', 'MIAMI'],
        ['North Carolina', 'UNC'],
        ['North Carolina State', 'NCST'],
        ['Virginia', 'UVA'],
        ['Virginia Tech', 'VT'],
        ['Wake Forest', 'WAKE']
      ],
      'Big 12' => [
        ['Baylor', 'BU'],
        ['Iowa State', 'ISU'],
        ['Kansas', 'KAN'],
        ['Kansas State', 'KSU'],
        ['Missouri', 'MIZZ'],
        ['Oklahoma', 'OU'],
        ['Oklahoma State', 'OSU'],
        ['Texas', 'TEXAS'],
        ['Texas A&M', 'TA&M'],
        ['Texas Tech', 'TTU']
      ],
      'Big East' => [
        ['Cincinnati', 'CIN'],
        ['Connecticut', 'UCONN'],
        ['Louisville', 'LOU'],
        ['Pittsburgh', 'PITT'],
        ['Rutgers', 'RU'],
        ['South Florida', 'USF'],
        ['Syracuse', 'SYR'],
        ['West Virginia', 'WVU'],
      ],
      'Big Ten' => [
        ['Illinois', 'ILL'],
        ['Indiana', 'IU'],
        ['Iowa', 'IOWA'],
        ['Michigan', 'MICH'],
        ['Michigan State', 'MSU'],
        ['Minnesota', 'MINN'],
        ['Nebraska', 'NEB'],
        ['Northwestern', 'NU'],
        ['Ohio State', 'OSU'],
        ['Penn State', 'PENN'],
        ['Purdue', 'PU'],
        ['Wisconsin', 'UW']
      ],
      'Conference USA' => [
        ['East Carolina', 'ECU'],
        ['Houston', 'HOU'],
        ['Marshall', 'MAR'],
        ['Memphis', 'MEM'],
        ['Rice', 'RICE'],
        ['Southern Methodist', 'SMU'],
        ['Southern Miss', 'USM'],
        ['Tulane', 'TU'],
        ['Tulsa', 'TULSA'],
        ['UAB', 'UAB'],
        ['UCF', 'UCF'],
        ['UTEP', 'UTEP']
      ],
      'IA Independents' => [
        ['Army', 'ARMY'],
        ['Brigham Young', 'BYU'],
        ['Navy', 'NAVY'],
        ['Notre Dame', 'UND']
      ],
      'Mid-American' => [
        ['Akron', 'AKRON'],
        ['Ball State', 'BSU'],
        ['Bowling Green', 'BGSU'],
        ['Buffalo', 'UB'],
        ['Central Michigan', 'CMU'],
        ['Eastern Michigan', 'EMU'],
        ['Kent State', 'KENT'],
        ['Miami (OH)', 'UM'],
        ['Northern Illinois', 'NIU'],
        ['Ohio', 'OHIO'],
        ['Temple', 'TEMP'],
        ['Toledo', 'TOLEDO'],
        ['Western Michigan', 'WMU']
      ],
      'Mountain West' => [
        ['Air Force', 'AFRC'],
        ['Boise State', 'BSU'],
        ['Colorado State', 'CSU'],
        ['New Mexico', 'NMU'],
        ['San Diego State', 'UNM'],
        ['TCU', 'TCU'],
        ['UNLV', 'UNLV'],
        ['Wyoming', 'UW']
      ],
      'Pacific-12' => [
        ['Arizona', 'UA'],
        ['Arizona State', 'ASU'],
        ['California', 'CAL'],
        ['Colorado', 'CU'],
        ['Oregon', 'ORE'],
        ['Oregon State', 'OSU'],
        ['Stanford', 'STAN'],
        ['UCLA', 'UCLA'],
        ['USC', 'USC'],
        ['Utah', 'UTAH'],
        ['Washington', 'WASH'],
        ['Washington State', 'WSU']
      ],
      'SEC' => [
        ['Alabama', 'BAMA'],
        ['Arkansas', 'ARK'],
        ['Auburn', 'AUB'],
        ['Florida', 'UF'],
        ['Georgia', 'UGA'],
        ['Kentucky', 'UK'],
        ['LSU', 'LSU'],
        ['Mississippi State', 'MSU'],
        ['Ole Miss', 'UM'],
        ['South Carolina', 'SCAR'],
        ['Tennessee', 'UT'],
        ['Vanderbilt', 'VANDY']
      ],
      'Sun Belt' => [
        ['Arkansas State', 'ASU'],
        ['Florida Atlantic', 'FAU'],
        ['Florida International', 'FIU'],
        ['Louisiana-Lafayette', 'UL'],
        ['Louisiana-Monroe', 'ULM'],
        ['Middle Tennessee', 'MTSU'],
        ['North Texas', 'UNT'],
        ['Troy', 'TROY'],
        ['Western Kentucky', 'WKU']
      ],
      'WAC' => [
        ['Fresno State', 'FRESNO'],
        ['Hawaii', 'HAWAII'],
        ['Idaho', 'IDAHO'],
        ['Louisiana Tech', 'LTU'],
        ['Nevada', 'NEV'],
        ['New Mexico State', 'NMSU'],
        ['San Jose State', 'SJSU'],
        ['Utah State', 'USU']
      ]
    },
    'I-AA' => {
      'Big Sky' => [
        ['Eastern Washington', ''],
        ['Idaho State', ''],
        ['Montana', ''],
        ['Montana State', ''],
        ['Northern Arizona', ''],
        ['Northern Colorado', ''],
        ['Portland State', ''],
        ['Sacramento State', ''],
        ['Weber State', '']
      ],
      'Big South' => [
        ['Charleston Southern', ''],
        ['Coastal Carolina', ''],
        ['Gardner-Webb', ''],
        ['Liberty', ''],
        ['Presbyterian', ''],
        ['Stony Brook', ''],
        ['Virginia Military Institute', '']
      ],
      'CAA' => [
        ['Delaware', ''],
        ['James Madison', ''],
        ['Maine', ''],
        ['Massachusetts', ''],
        ['New Hampshire', ''],
        ['Old Dominion', ''],
        ['Rhode Island', ''],
        ['Richmond', ''],
        ['Towson', ''],
        ['Villanova', ''],
        ['William & Mary', '']
      ],
      'Great West' => [
        ['Cal Poly', ''],
        ['North Dakota', ''],
        ['South Dakota', ''],
        ['Souhtern Utah', ''],
        ['UC Davis', '']
      ],
      'IAA Independents' => [
        ['Georgia State', ''],
        ['South Alabama', ''],
        ['Texas State', ''],
        ['Texas-San Antonio', '']
      ],
      'Ivy' => [
        ['Brown', ''],
        ['Columbia', ''],
        ['Cornell', ''],
        ['Dartmouth', ''],
        ['Harvard', ''],
        ['Pennsylvania', ''],
        ['Princeton', ''],
        ['Yale', '']
      ],
      'MEAC' => [
        ['Berthune-Cookman', ''],
        ['Delaware State', ''],
        ['Florida A&M', ''],
        ['Hampton', ''],
        ['Howard', ''],
        ['Morgan State', ''],
        ['Norfolk State', ''],
        ['North Carolina A&T', ''],
        ['North Carolina Central', ''],
        ['Savannah State', ''],
        ['South Carolina State', '']
      ],
      'Missouri Valley' => [
        ['Illinois State', ''],
        ['Indiana State', ''],
        ['Missouri State', ''],
        ['North Dakota State', ''],
        ['Northern Iowa', ''],
        ['South Dakota State', ''],
        ['Southern Illinois', ''],
        ['Western Illinois', ''],
        ['Youngstown State', '']
      ],
      'Northeast' => [
        ['Albany', ''],
        ['Bryant University', ''],
        ['Central Connecticut State', ''],
        ['Duquesne', ''],
        ['Monmouth', ''],
        ['Robert Morris', ''],
        ['Sacred Heart', ''],
        ['St. Francis (PA)', ''],
        ['Wagner', '']
      ],
      'Ohio Valley' => [
        ['Austin Peay', ''],
        ['Eastern Illinois', ''],
        ['Eastern Kentucky', ''],
        ['Jacksonville State', ''],
        ['Murray State', ''],
        ['Southeast Missouri State', ''],
        ['Tennessee State', ''],
        ['Tennessee Tech', ''],
        ['Tennessee-Martin', '']
      ],
      'Patriot League' => [
        ['Bucknell', ''],
        ['Colgate', ''],
        ['Fordham', ''],
        ['Georgetown', ''],
        ['Holy Cross', ''],
        ['Lafayette', ''],
        ['Lehigh', '']
      ],
      'Pioneer' => [
        ['Butler', ''],
        ['Campbell', ''],
        ['Davidson', ''],
        ['Dayton', ''],
        ['Drake', ''],
        ['Jacksonville', ''],
        ['Marist', ''],
        ['Morehead State', ''],
        ['San Diego', ''],
        ['Valparaiso', '']
      ],
      'Southland' => [
        ['Appalachain State', ''],
        ['Chattanooga', ''],
        ['Citadel', ''],
        ['Elon', ''],
        ['Furman', ''],
        ['Georgia Southern', ''],
        ['Samford', ''],
        ['Western Carolina', ''],
        ['Wofford', '']
      ],
      'SWAC' => [
        ['Alabama A&M', ''],
        ['Alabama State', ''],
        ['Alcorn State', ''],
        ['Arkansas-Pine Bluff', ''],
        ['Grambling State', ''],
        ['Jackson State', ''],
        ['Mississippi Valley State', ''],
        ['Prairie View A&M', ''],
        ['Southern University', ''],
        ['Texas Southern', '']
      ]
    }
  }.each do |division, conferences|
    conferences.each do |conference, colleges|
      conf = Conference.create!(:name => conference, :division => division, :permalink => conference.downcase.gsub(' ', '-'))
      colleges.each do |name, abbrev|
        conf.colleges.create!(:name => name, :abbrev => abbrev)
      end
    end
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