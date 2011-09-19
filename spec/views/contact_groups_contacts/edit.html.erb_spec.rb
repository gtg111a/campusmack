require 'spec_helper'

describe "contact_groups_contacts/edit.html.erb" do
  before(:each) do
    @contact_groups_contact = assign(:contact_groups_contact, stub_model(ContactGroupsContact,
      :contact_id => 1,
      :contact_group_id => 1
    ))
  end

  it "renders the edit contact_groups_contact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contact_groups_contacts_path(@contact_groups_contact), :method => "post" do
      assert_select "input#contact_groups_contact_contact_id", :name => "contact_groups_contact[contact_id]"
      assert_select "input#contact_groups_contact_contact_group_id", :name => "contact_groups_contact[contact_group_id]"
    end
  end
end
