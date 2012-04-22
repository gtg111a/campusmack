require 'spec_helper'

describe ContactsController do
  let(:admin) { FactoryGirl.create(:user, :role => "admin", :college => FactoryGirl.create(:college) ) }
  let(:contact_group) { FactoryGirl.create(:contact_group)}
  before { @admin = admin; @admin.confirm!; sign_in @admin;  controller.class.skip_before_filter :ensure_domain }
  
  def valid_attributes
    {:name => Faker::Name.name, :user_id => @admin.id, :email => Faker::Internet.email}
  end

  describe "GET index" do
    it "assigns all contacts as @contacts" do
      contact = Contact.create! valid_attributes
      get :index
      assigns(:contacts).should eq([contact])
    end
  end

  describe "GET new" do
    it "assigns a new contact as @contact" do
      get :new
      assigns(:contact).should be_a_new(Contact)
    end
  end

  describe "GET edit" do
    it "assigns the requested contact as @contact" do
      contact = Contact.create! valid_attributes
      get :edit, :id => contact.id.to_s
      assigns(:contact).should eq(contact)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before { @contact_group = contact_group }
      it "creates a new Contact" do
        expect {
          post :create, :contact => valid_attributes, :format => :js, :group_id => ""
        }.to change(Contact, :count).by(1)
      end

      it "respond with js" do
        post :create, :contact => valid_attributes, :group_id => "", :format => :js
        should respond_with_content_type(:js)
      end

    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested contact" do
        contact = Contact.create! valid_attributes
        # Assuming there are no other contacts in the database, this
        # specifies that the Contact created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Contact.any_instance.should_receive(:update_attributes).with({'name' => 'new_name'})
        put :update, :id => contact.id, :contact => {'name' => 'new_name'}
      end
    end

    describe "with invalid params" do
      it "instance not updated" do
        contact = Contact.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        put :update, :id => contact.id.to_s, :contact => {}
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested contact" do
      contact = Contact.create! valid_attributes
      expect {
        delete :destroy, :id => contact.id.to_s
      }.to change(Contact, :count).by(-1)
    end

    it "redirects to the contacts list" do
      contact = Contact.create! valid_attributes
      delete :destroy, :id => contact.id.to_s
      response.should redirect_to(contacts_url)
    end
  end

end
