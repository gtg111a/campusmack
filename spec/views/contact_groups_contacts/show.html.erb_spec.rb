require 'spec_helper'

describe "contact_groups_contacts/show.html.erb" do
  before(:each) do
    @contact_groups_contact = assign(:contact_groups_contact, stub_model(ContactGroupsContact,
      :contact_id => 1,
      :contact_group_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
