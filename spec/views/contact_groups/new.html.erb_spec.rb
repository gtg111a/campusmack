require 'spec_helper'

describe "contact_groups/new.html.erb" do
  before(:each) do
    assign(:contact_group, stub_model(ContactGroup,
      :user_id => 1,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new contact_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contact_groups_path, :method => "post" do
      assert_select "input#contact_group_user_id", :name => "contact_group[user_id]"
      assert_select "input#contact_group_name", :name => "contact_group[name]"
    end
  end
end
