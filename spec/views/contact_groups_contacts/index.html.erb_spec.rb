require 'spec_helper'

describe "contact_groups_contacts/index.html.erb" do
  before(:each) do
    assign(:contact_groups_contacts, [
      stub_model(ContactGroupsContact,
        :contact_id => 1,
        :contact_group_id => 1
      ),
      stub_model(ContactGroupsContact,
        :contact_id => 1,
        :contact_group_id => 1
      )
    ])
  end

  it "renders a list of contact_groups_contacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
