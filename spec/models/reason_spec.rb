require 'spec_helper'

describe Reason do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:reason).should be_valid
  end

  it "should require a caption" do
    FactoryGirl.build(:reason, :reason => nil).should_not be_nil
  end

end