require 'spec_helper'

describe "Report page" do

  before do
    @user = Factory(:user, :admin => true)
    @user2 = Factory(:user)
    @college = Factory(:college)
    @college.users << @user
    Factory(:smack, :user => @user)
    @deliveries = FactoryGirl.create_list(:delivery, 3, :user => @user, :college => @college, :post => @smack, :recipients => 10)
    @deliveries << FactoryGirl.create_list(:delivery, 2, :user => @user2, :college => @college, :post => @smack, :recipients => 20)
    login @user
  end

  describe "users" do
    before { visit users_reports_path }
    it "smacks count should match" do
      page.should have_content(@user.username)
      within_table("users_table") do
        page.should have_content(@user.posts.count)
        page.should have_content(@user2.posts.count)
        page.should have_content(@user.deliveries.count) # Posts send as smack for user1
        page.should have_content("30") # Sum nonuniq people
      end
    end
    it "should counter_cache correctly" do
      @user.reload
      @user.posts.count.should == @user.posts_count
      @user.deliveries.count.should == @user.deliveries_count
    end
  end

  describe "colleges" do
    before { visit colleges_reports_path }
    it "users count should match" do
      page.should have_content(@college.name)
      within_table("colleges_table") do
        page.should have_content(@college.users.count)
      end
    end
    it "should counter_cache correctly" do
      @college.users.count.should == @college.users_count
    end
  end
end
