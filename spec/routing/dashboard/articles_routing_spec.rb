require "spec_helper"

describe Dashboard::ArticlesController do
  describe "routing" do

    it "routes to #index" do
      get("/dashboard/articles").should route_to("dashboard/articles#index")
    end

    it "routes to #new" do
      get("/dashboard/articles/new").should route_to("dashboard/articles#new")
    end

    it "routes to #show" do
      get("/dashboard/articles/1").should route_to("dashboard/articles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dashboard/articles/1/edit").should route_to("dashboard/articles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dashboard/articles").should route_to("dashboard/articles#create")
    end

    it "routes to #update" do
      put("/dashboard/articles/1").should route_to("dashboard/articles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dashboard/articles/1").should route_to("dashboard/articles#destroy", :id => "1")
    end

  end
end
