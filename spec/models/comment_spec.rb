require 'spec_helper'

describe Comment do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:user).should be_valid
  end

  it "should require title" do
    FactoryGirl.build(:comment, :title => nil).should_not be_nil
  end

  it "should require comment" do
    FactoryGirl.build(:comment, :comment => nil).should_not be_nil
  end

  it "should require a user" do
    FactoryGirl.build(:comment, :user_id => nil).should_not be_nil
  end

  it "should not require reports count" do
    FactoryGirl.build(:comment, :reports_count => nil).should be_valid
  end

end