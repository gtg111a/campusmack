require "spec_helper"

describe ContactGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/contact_groups").should route_to("contact_groups#index")
    end

    it "routes to #new" do
      get("/contact_groups/new").should route_to("contact_groups#new")
    end

    it "routes to #show" do
      get("/contact_groups/1").should route_to("contact_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/contact_groups/1/edit").should route_to("contact_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/contact_groups").should route_to("contact_groups#create")
    end

    it "routes to #update" do
      put("/contact_groups/1").should route_to("contact_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/contact_groups/1").should route_to("contact_groups#destroy", :id => "1")
    end

  end
end
