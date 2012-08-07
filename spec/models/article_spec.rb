require 'spec_helper'

describe Article do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:article).should be_valid
  end

  it "should require body" do
    FactoryGirl.build(:article, :body => nil).should_not be_nil
  end

  it "should require video url" do
    FactoryGirl.build(:article, :video_url => nil).should_not be_nil
  end

  it "should not require image file " do
    FactoryGirl.build(:article, :image_file_name => nil).should be_valid
  end

  it "should not require image content type " do
    FactoryGirl.build(:article, :image_content_type => nil).should be_valid
  end

  it "should not require image file size " do
    FactoryGirl.build(:article, :image_file_size => nil).should be_valid
  end

  it "should have a post" do
    FactoryGirl.build(:article, :post_id => nil).should_not be_nil
  end
end