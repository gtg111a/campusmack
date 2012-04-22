require 'spec_helper'

describe Photo do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:photo).should be_valid
  end

  it "should require a caption" do
    FactoryGirl.build(:photo, :caption => nil).should_not be_nil
  end

  it "should require a image file name" do
    FactoryGirl.build(:photo, :image_file_name => nil).should_not be_nil
  end

  it "should require an image content type" do
    FactoryGirl.build(:photo, :image_content_type => nil).should_not be_nil
  end

  it "should require an image file size" do
    FactoryGirl.build(:photo, :image_file_size => nil).should_not be_nil
  end

  it "should require an image updated at" do
    FactoryGirl.build(:photo, :image_updated_at => nil).should_not be_nil
  end

end