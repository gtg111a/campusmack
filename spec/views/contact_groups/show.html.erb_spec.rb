require 'spec_helper'

describe "contact_groups/show.html.erb" do
  before(:each) do
    @contact_group = assign(:contact_group, stub_model(ContactGroup,
      :user_id => 1,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
