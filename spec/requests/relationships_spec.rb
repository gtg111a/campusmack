require 'spec_helper'
require 'factories'

describe "Relationships" do

  before(:each) do 
    user = Factory(:user) 
    other = Factory(:user, :email => Factory.next(:email))
    visit signin_path 
    fill_in :email,	:with => user.email 
    fill_in :password, :with => user.password 
    click_button
  end

  describe "follow" do
    
    it "should follow a user" do
    visit '/users/2'
    click_link "Follow"
     response.should have_selector(:span, :content => "1 following")
   end
 end
end
 

    
