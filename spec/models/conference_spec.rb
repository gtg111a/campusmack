require 'spec_helper'

describe Conference do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:conference).should be_valid
  end

  it "should require name" do
    FactoryGirl.build(:conference, :name => nil).should_not be_nil
  end

  it "should require division" do
    FactoryGirl.build(:conference, :division => nil).should_not be_nil
  end

  it "should require permalink " do
    FactoryGirl.build(:conference, :permalink => nil).should_not be_nil
  end

  it "should require weight" do
    FactoryGirl.build(:conference, :weight => nil).should_not be_nil
  end

end