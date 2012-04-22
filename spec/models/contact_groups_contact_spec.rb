require 'spec_helper'

describe ContactGroupsContact do

  it "should require a contact" do
    FactoryGirl.build(:contact_groups_contact, :contact_id => nil).should_not be_nil
  end

  it "should require a contact group" do
    FactoryGirl.build(:contact_groups_contact, :contact_group_id => nil).should_not be_nil
  end


end