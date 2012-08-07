require 'spec_helper'

describe ContactGroup do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:contact_group).should be_valid
  end

  it "should require a user" do
    FactoryGirl.build(:contact_group, :user_id => nil).should_not be_nil
  end

  it "should require a name" do
    FactoryGirl.build(:contact_group, :name => nil).should_not be_nil
  end

end