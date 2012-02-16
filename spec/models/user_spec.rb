require 'spec_helper'

describe User do

  it "should create a new instance given a valid attribute" do
    Factory(:user).should be_valid
  end

  it "should require name and username" do
    Factory.build(:user, :first_name => nil).should_not be_valid
    Factory.build(:user, :last_name => nil).should_not be_valid
    Factory.build(:user, :username => nil).should_not be_valid
  end

  it "should require an email address" do
    Factory.build(:user, :email => nil).should_not be_valid
  end

  it "should reject names that are too long" do
    Factory.build(:user, :username => 'a' * 51).should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      Factory.build(:user, :email => address).should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      Factory.build(:user, :email => address).should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    user = Factory(:user)
    Factory.build(:user, :email => user.email).should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    user = Factory(:user)
    Factory.build(:user, :email => user.email.upcase).should_not be_valid
  end

  it "should not require birthday" do
    Factory.build(:user, :birthday => nil).should be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = Factory(:user)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      Factory.build(:user, :password => '', :password_confirmation => '').should_not be_valid
    end

    it "should require a matching password confirmation" do
      Factory.build(:user, :password_confirmation => 'invalid').should_not be_valid
    end

    it "should reject short passwords" do
      short_pw = 'a' * 5
      Factory.build(:user, :password => short_pw, :password_confirmation => short_pw).should_not be_valid
    end

# FIXME Why?
#    it "should reject long passwords" do
#      long_pw = 'a' * 41
#      Factory.build(:user, :password => long_pw, :password_confirmation => long_pw).should_not be_valid
#    end
  end

  describe "admin attribute" do

    before(:each) do
      @user = Factory(:user)
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

  describe "relationships" do

    before(:each) do
      @user = Factory(:user)
      @followed = Factory(:user)
    end

    it "should have a relationships method" do
      @user.should respond_to(:relationships)
    end

    it "should have a following method" do
      @user.should respond_to(:following)
    end

    it "should follow another user" do
      @user.follow!(@followed)
      @user.should be_following(@followed)
    end

    it "should include the followed user in the following array" do
      @user.follow!(@followed)
      @user.following.should include(@followed)
    end

    it "should have an unfollow! method" do
      @user.should respond_to(:unfollow!)
    end

    it "should unfollow a user" do
      @user.follow!(@followed)
      @user.unfollow!(@followed)
      @user.should_not be_following(@followed)
    end

    it "should have a reverse_relationships method" do
      @user.should respond_to(:reverse_relationships)
    end

    it "should have a followers method" do
      @user.should respond_to(:followers)
    end

    it "should include the follower in the followers array" do
      @user.follow!(@followed)
      @followed.followers.should include(@user)
    end
  end

  describe "relationship associations" do
    before(:each) do
      @follower = Factory(:user)
      @followed = Factory(:user)
      @relationship = @follower.relationships.build(:followed_id => @followed.id)
      @relationship.save
    end

    it "should destroy associated relationships" do
      @follower.destroy
      Relationship.find_by_follower_id(@follower.id).should be nil
    end
  end
end






# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  username               :string(255)     indexed
#  email                  :string(255)     not null, indexed
#  first_name             :string(255)
#  last_name              :string(255)
#  college_id             :integer(4)
#  affiliation            :string(255)
#  up_votes               :integer(4)
#  down_votes             :integer(4)
#  encrypted_password     :string(128)     not null
#  reset_password_token   :string(255)     indexed
#  reset_password_sent_at :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  censor_text            :boolean(1)      default(TRUE)
#  gender                 :string(1)
#  birthday               :date
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer(4)
#  avatar_updated_at      :datetime
#  posts_count            :integer(4)      default(0)
#  deliveries_count       :integer(4)      default(0)
#  role                   :string(255)     default("user")
#
# Indexes
#
#  index_users_on_email                 (email)
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_username              (username)
#

