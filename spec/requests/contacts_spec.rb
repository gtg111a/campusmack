require 'spec_helper'

describe "Contacts", :js => true, :type => :request  do
  let(:contact_group) { FactoryGirl.create(:contact_group)}
  before(:each) do
    @user = FactoryGirl.create(:user, :admin => true)
    @contact_groups = FactoryGirl.create_list(:contact_group, 2, :user => @user)
    @contacts = FactoryGirl.create_list(:contact, 5,
                  :contact_groups => [@contact_groups[0]], :user => @user) +
                FactoryGirl.create_list(:contact, 5,
                  :contact_groups => [@contact_groups[1]], :user => @user)
    @user.confirm!
    login @user
    visit contacts_path
  end

  describe "edit/add groups popup" do
    before { click_link "Edit / Add groups" }
    it "add groups" do
      within(:css, "div#facebox") do
        page.should have_content("All contact groups")
        click_link "New contact group"
        fill_in 'Name', :with => 'newgroup'
        click_button "contact_group_submit"
        page.should have_content("newgroup")
        page.find(:css, "a.close").click
      end
      within(:css, "ul.contact_groups") { page.should have_content("newgroup") }
    end
    it "edit groups" do
      within(:css, "div#facebox") do
        page.should have_content("All contact groups")
        contact_group = @contact_groups.first
        page.should have_content(contact_group.name)
        within(:css, "tr##{contact_group.id}") do
          click_on "Edit"
        end
        find_field("Name").value.should == contact_group.name
        fill_in "Name", :with => "#{contact_group.name}_changed"
        click_on "contact_group_submit"
        page.should have_content("#{contact_group.name}_changed")
      end
    end
    it "destroy group" do
      contact_group = @contact_groups.first
      within(:css, "div#facebox tr##{contact_group.id}") do
        @group_name = find(:css, "td.facebox_form_name_td").text
        click_on "Destroy"
        handle_js_confirm
      end
      within(:css, "div#facebox") do
        page.should have_no_content(@group_name)
        page.find(:css, "a.close").click
      end
      page.should have_no_content(@group_name)
    end
  end

  describe "Add to" do
    before do
      @proper_name = @contacts.first.name
      check("contact_chk_box#{@contacts.first.id}")
      click_on "Add To Group"
    end
    it "adds to existing group" do
      within(:css, "div#contact_group_form") do
        select @contact_groups.first.name, :from => "group_id"
        click_on "Add contacts"
      end
      click_on @contact_groups.first.name
      page.should have_content(@proper_name.to_s)
    end
    it "adds to new group" do
      within(:css, "div#contact_group_form") do
        fill_in "contact_group_name", :with => "newgroup"
        choose "contact_group_name_radio"
        click_on "Add contacts"
      end
      click_on "newgroup"
      page.should have_content("newgroup")
      page.should have_content(@proper_name)
    end
  end

  describe "delete selected" do
    it "delets single contact" do
      page.should have_content(@contacts.first.name)
      check("contact_chk_box#{@contacts.first.id}")
      page.find("li#delete_selected").click
      page.should have_no_content(@contacts.first.name)
    end
    it "deletes many contacts" do
      page.should have_selector("#rowclick1 tbody")
      check("select_all_chk_box")
      page.find("li#delete_selected").click
      page.should have_no_selector("#rowclick1 tbody") #check to ensure we don't have contacts
    end
  end

  describe "remove selected" do
    it "removes from group only" do
      click_on @contact_groups.first.name
      check("contact_chk_box#{@contacts.first.id}")
      page.find("li#remove_selected").click
      page.should have_no_content(@contacts.first.name) #dont have in group
      click_on "All"
      page.should have_content(@contacts.first.name) #but dont deleted
    end
  end

  describe "edit contact" do
    it "changed contact information" do
      contact = @contact_groups.first.contacts.first
      within(:css, "div#contact_list tr##{contact.id}") do
        click_on "Edit"
      end
      fill_in "Name", :with => "name_changed"
      fill_in "Email", :with => "changed@example.com"
      click_on "contact_submit"
      page.should have_content("name_changed")
      page.should have_content("changed@example.com")
    end
  end

end
