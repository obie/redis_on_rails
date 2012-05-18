require "spec_helper"

describe TalksController do
  describe "routing" do

    it "routes to #index" do
      get("/talks").should route_to("talks#index")
    end

    it "routes to #new" do
      get("/talks/new").should route_to("talks#new")
    end

    it "routes to #show" do
      get("/talks/1").should route_to("talks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/talks/1/edit").should route_to("talks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/talks").should route_to("talks#create")
    end

    it "routes to #update" do
      put("/talks/1").should route_to("talks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/talks/1").should route_to("talks#destroy", :id => "1")
    end

  end
end
