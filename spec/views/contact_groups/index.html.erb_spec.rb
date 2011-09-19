require 'spec_helper'

describe "contact_groups/index.html.erb" do
  before(:each) do
    assign(:contact_groups, [
      stub_model(ContactGroup,
        :user_id => 1,
        :name => "Name"
      ),
      stub_model(ContactGroup,
        :user_id => 1,
        :name => "Name"
      )
    ])
  end

  it "renders a list of contact_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
