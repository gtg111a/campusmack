require 'spec_helper'

describe Delivery do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:delivery).should be_valid
  end

  it "should require user" do
    FactoryGirl.build(:delivery, :user_id => nil).should_not be_nil
  end

  it "should require a post" do
    FactoryGirl.build(:delivery, :post_id => nil).should_not be_nil
  end

  it "should require a college" do
    FactoryGirl.build(:delivery, :college_id => nil).should_not be_nil
  end

  it "should require a recipients" do
    FactoryGirl.build(:delivery, :recipients => nil).should_not be_nil
  end

end