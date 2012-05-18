require "spec_helper"

describe TutorialsController do
  describe "routing" do

    it "routes to #index" do
      get("/tutorials").should route_to("tutorials#index")
    end

    it "routes to #new" do
      get("/tutorials/new").should route_to("tutorials#new")
    end

    it "routes to #show" do
      get("/tutorials/1").should route_to("tutorials#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tutorials/1/edit").should route_to("tutorials#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tutorials").should route_to("tutorials#create")
    end

    it "routes to #update" do
      put("/tutorials/1").should route_to("tutorials#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tutorials/1").should route_to("tutorials#destroy", :id => "1")
    end

  end
end
