require 'spec_helper'

describe NewsPost do

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:maintenance).should be_valid
  end

    it "should require an url" do
    FactoryGirl.build(:news_post, :url => nil).should_not be_nil
  end

  it "should require an image file name" do
    FactoryGirl.build(:news_post, :image_file_name => nil).should_not be_nil
  end

  it "should require and image content type " do
    FactoryGirl.build(:news_post, :image_content_type => nil).should_not be_nil
  end

  it "should require and image file size" do
    FactoryGirl.build(:news_post, :image_file_size => nil).should_not be_nil
  end

  it "should require an image updated at" do
    FactoryGirl.build(:news_post, :image_updated_at => nil).should_not be_nil
  end

  it "should require a video url" do
    FactoryGirl.build(:news_post, :video_url=> nil).should_not be_nil
  end

end