require 'rails_helper'

RSpec.describe AircraftsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: 'aircraft_models/1/aircrafts').to route_to('aircrafts#index', aircraft_model_icao_code: '1')
    end

    it 'routes to #show' do
      expect(get: '/aircrafts/1').to route_to('aircrafts#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: 'aircraft_models/1/aircrafts').to route_to('aircrafts#create', aircraft_model_icao_code: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/aircrafts/1').to route_to('aircrafts#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/aircrafts/1').to route_to('aircrafts#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/aircrafts/1').to route_to('aircrafts#destroy', id: '1')
    end

  end
end
