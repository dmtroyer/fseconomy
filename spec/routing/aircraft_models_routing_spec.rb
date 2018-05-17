require "rails_helper"

RSpec.describe AircraftModelsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/aircraft_models").to route_to("aircraft_models#index")
    end


    it "routes to #show" do
      expect(:get => "/aircraft_models/1").to route_to("aircraft_models#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/aircraft_models").to route_to("aircraft_models#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/aircraft_models/1").to route_to("aircraft_models#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/aircraft_models/1").to route_to("aircraft_models#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/aircraft_models/1").to route_to("aircraft_models#destroy", :id => "1")
    end

  end
end
