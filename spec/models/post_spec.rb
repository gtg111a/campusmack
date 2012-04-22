require 'spec_helper'

describe Post do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:post).should be_valid
  end

  it "should require a title" do
    FactoryGirl.build(:post, :title => nil).should_not be_valid
  end

  it "should require a summary" do
    FactoryGirl.build(:post, :summary => nil).should_not be_valid
  end

  it "should require a type" do
    FactoryGirl.build(:post, :type => nil).should_not be_valid
  end

  it "should require a published" do
    FactoryGirl.build(:post, :published => nil).should_not be_valid
  end

  it "should require a postable id" do
    FactoryGirl.build(:post, :postable_id => nil).should_not be_valid
  end

  it "should require a postable type" do
    FactoryGirl.build(:post, :postable_type => nil).should_not be_valid
  end

  it "should require user" do
    FactoryGirl.build(:post, :user_id => nil).should_not be_valid
  end

  it "should require a front page week" do
    FactoryGirl.build(:post, :on_front_page_week => nil).should_not be_valid
  end

  it "should require a report count" do
    FactoryGirl.build(:post, :reports_count => nil).should be_valid
  end

  it "should require a up votes" do
    FactoryGirl.build(:post, :up_votes => nil).should be_valid
  end

  it "should require a down votes" do
    FactoryGirl.build(:post, :down_votes => nil).should be_valid
  end
end
