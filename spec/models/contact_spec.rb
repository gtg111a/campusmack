require 'spec_helper'

describe Contact do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:contact).should be_valid
  end

  it "should require a user" do
    FactoryGirl.build(:contact, :user_id => nil).should_not be_nil
  end

  it "should require a name" do
    FactoryGirl.build(:contact, :name => nil).should_not be_nil
  end

  it "should require a email" do
    FactoryGirl.build(:contact, :email => nil).should_not be_nil
  end

end