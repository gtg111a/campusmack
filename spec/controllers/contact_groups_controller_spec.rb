require 'spec_helper'

describe ContactGroupsController do
  let(:admin) { FactoryGirl.create(:user, :role => "admin", :college => FactoryGirl.create(:college) ) }
  before {@admin = admin; @admin.confirm!; sign_in @admin;  controller.class.skip_before_filter :ensure_domain}
  
  def valid_attributes
    {:name => Faker::Name.name, :user_id => @admin.id }
  end

  describe "GET index" do
    before { @contact_group = ContactGroup.create! valid_attributes }
    it "assigns all contact_groups as @contact_groups" do
      get :index
      assigns(:contact_groups).should == [@contact_group]
    end
  end

  describe "GET show" do
    it "assigns the requested contact_group as @contact_group" do
      contact_group = ContactGroup.create! valid_attributes
      get :show, :id => contact_group.id.to_s
      assigns(:contact_group).should eq(contact_group)
    end
  end

  describe "GET new" do
    it "assigns a new contact_group as @contact_group" do
      get :new
      assigns(:contact_group).should be_a_new(ContactGroup)
    end
  end

  describe "GET edit" do
    it "assigns the requested contact_group as @contact_group" do
      contact_group = ContactGroup.create! valid_attributes
      get :edit, :id => contact_group.id.to_s
      assigns(:contact_group).should eq(contact_group)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ContactGroup" do
        expect {
          post :create, :contact_group => valid_attributes
        }.to change(ContactGroup, :count).by(1)
      end

      it "assigns a newly created contact_group as @contact_group" do
        post :create, :contact_group => valid_attributes
        assigns(:contact_group).should be_a(ContactGroup)
        assigns(:contact_group).should be_persisted
      end

      it "render update with format js" do
        post :create, :contact_group => valid_attributes, :format => :js
        should render_template(:update)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved contact_group as @contact_group" do
        # Trigger the behavior that occurs when invalid params are submitted
        ContactGroup.any_instance.stub(:save).and_return(false)
        post :create, :contact_group => {}
        assigns(:contact_group).should be_a_new(ContactGroup)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested contact_group" do
        contact_group = ContactGroup.create! valid_attributes
        # Assuming there are no other contact_groups in the database, this
        # specifies that the ContactGroup created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ContactGroup.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => contact_group.id, :contact_group => {'these' => 'params'}
      end

      it "assigns the requested contact_group as @contact_group" do
        contact_group = ContactGroup.create! valid_attributes
        put :update, :id => contact_group.id, :contact_group => valid_attributes
        assigns(:contact_group).should eq(contact_group)
      end
    end

    describe "with invalid params" do
      it "assigns the contact_group as @contact_group" do
        contact_group = ContactGroup.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ContactGroup.any_instance.stub(:save).and_return(false)
        put :update, :id => contact_group.id.to_s, :contact_group => {}
        assigns(:contact_group).should eq(contact_group)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested contact_group" do
      contact_group = ContactGroup.create! valid_attributes
      expect {
        delete :destroy, :id => contact_group.id.to_s
      }.to change(ContactGroup, :count).by(-1)
    end

    it "redirects to the contact_groups list" do
      contact_group = ContactGroup.create! valid_attributes
      delete :destroy, :id => contact_group.id.to_s
      response.body.should be_blank
    end
  end

end
