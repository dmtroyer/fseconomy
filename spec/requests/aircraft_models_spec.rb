require 'rails_helper'

RSpec.describe "AircraftModels", type: :request do
  describe "GET /aircraft_models" do
    it "works! (now write some real specs)" do
      get aircraft_models_path
      expect(response).to have_http_status(200)
    end
  end
end
