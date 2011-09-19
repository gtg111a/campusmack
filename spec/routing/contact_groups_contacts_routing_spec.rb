require "spec_helper"

describe ContactGroupsContactsController do
  describe "routing" do

    it "routes to #index" do
      get("/contact_groups_contacts").should route_to("contact_groups_contacts#index")
    end

    it "routes to #new" do
      get("/contact_groups_contacts/new").should route_to("contact_groups_contacts#new")
    end

    it "routes to #show" do
      get("/contact_groups_contacts/1").should route_to("contact_groups_contacts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/contact_groups_contacts/1/edit").should route_to("contact_groups_contacts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/contact_groups_contacts").should route_to("contact_groups_contacts#create")
    end

    it "routes to #update" do
      put("/contact_groups_contacts/1").should route_to("contact_groups_contacts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/contact_groups_contacts/1").should route_to("contact_groups_contacts#destroy", :id => "1")
    end

  end
end
