require 'spec_helper'
require 'posts_helper'
require 'factories_helper'

describe "Send smack", :js => true, :type => :request  do
  before(:each) do
    @conference = FactoryGirl.create(:conference)
    @college = FactoryGirl.create(:college, :conference => @conference)
    @user = FactoryGirl.create(:user, :admin => true)
    @smack = FactoryGirl.create(:smack, :type => "Smack")
    @video_link = "http://www.youtube.com/watch?v=UaWXbqu5Bcs"
    @video_hash = "UaWXbqu5Bcs"
    @user.confirm!
    login @user
  end
  describe  "smack" do  
    context "creating" do   
      before { visit college_path(@college)}
      it "should create video" do
        click_on "Add Smack"
        fill_in "Title", :with => "Testing smack"
        fill_in "URL", :with => @video_link
        fill_in "Summary", :with => Faker::Lorem.sentences.join(". ")
        click_on "smack_submit"
        page.should have_content("#{@college.name} Smack Submitted Successfully!")
      end
      it "should create photo" do
        click_on "Add Smack"
        find(:css, "#switch_photo").click
        fill_in "Title", :with => "Testing smack"
        page.attach_file("Photo:", File.dirname(__FILE__) + '/../test-images/rails.png')
        fill_in "Summary", :with => Faker::Lorem.sentences.join(". ")  
        click_on "smack_submit"
        page.should have_content("#{@college.name} Smack Submitted Successfully!")
        page.should have_css('div.preview a img')
      end
      it "should create news" do
        click_on "Add Smack"
        find(:css, "#switch_news").click
        fill_in "Title", :with => "Testing smack"
        fill_in "Summary", :with => Faker::Lorem.sentences.join(". ")
        fill_in "URL", :with => random_url
        click_on "smack_submit"
        page.should have_content("#{@college.name} Smack Submitted Successfully!")
        page.should have_content("Testing smack")
      end
    end
    it "should be voteable" do
      visit college_smacks_path(@college)
      first(:css, ".vote_up").click
      @smack.reload
      @smack.up_votes.should == 1
      @smack.down_votes.should == 0
    end    
  end  
  
end