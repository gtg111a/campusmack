require 'spec_helper'

describe User do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:user).should be_valid
  end

  it "should require name and username" do
    FactoryGirl.build(:user, :first_name => nil).should_not be_valid
    FactoryGirl.build(:user, :username => nil).should_not be_valid
  end

  it "should require an email address" do
    FactoryGirl.build(:user, :email => nil).should_not be_valid
  end

  it "should reject names that are too long" do
    FactoryGirl.build(:user, :username => 'a' * 51).should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      FactoryGirl.build(:user, :email => address).should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      FactoryGirl.build(:user, :email => address).should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    user = FactoryGirl.create(:user)
    FactoryGirl.build(:user, :email => user.email).should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    user = FactoryGirl.create(:user)
    FactoryGirl.build(:user, :email => user.email.upcase).should_not be_valid
  end

  it "should not require birthday" do
    FactoryGirl.build(:user, :birthday => nil).should be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

  end


# FIXME Why?
#    it "should reject long passwords" do
#      long_pw = 'a' * 41
#      FactoryGirl.build(:user, :password => long_pw, :password_confirmation => long_pw).should_not be_valid
#    end
  end

  describe "admin attribute" do

    before(:each) do
      @user = FactoryGirl(:user)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

end



# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  username               :string(255)     indexed
#  email                  :string(255)     default(""), not null, indexed
#  first_name             :string(255)
#  last_name              :string(255)
#  admin                  :boolean         default(FALSE)
#  college_id             :integer
#  affiliation            :string(255)
#  up_votes               :integer
#  down_votes             :integer
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)     indexed
#  reset_password_sent_at :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  censor_text            :boolean         default(TRUE)
#  smack_count            :integer         default(0)
#  gender                 :string(1)
#  birthday               :date
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  posts_count            :integer         default(0)
#  deliveries_count       :integer         default(0)
#
# Indexes
#
#  index_users_on_username              (username)
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_email                 (email)
#

