require 'spec_helper'

describe College do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:college).should be_valid
  end

  it "should require name" do
    FactoryGirl.build(:college, :name => nil).should_not be_nil
  end

  it "should require conference" do
    FactoryGirl.build(:college, :conference_id => nil).should_not be_nil
  end

  it "should require permalink" do
    FactoryGirl.build(:college, :permalink => nil).should_not be_nil
  end

  it "should require abbrev" do
    FactoryGirl.build(:college, :abbrev => nil).should_not be_nil
  end

  it "should not require smacks count" do
    FactoryGirl.build(:college, :smacks_count => nil).should be_valid
  end

  it "should not require redemptions count" do
    FactoryGirl.build(:college, :redemptions_count => nil).should be_valid
  end

  it "should require users count" do
    FactoryGirl.build(:college, :users_count => nil).should_not be_nil
  end

end