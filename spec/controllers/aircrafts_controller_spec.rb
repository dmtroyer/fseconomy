require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe AircraftsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Aircraft. As you add validations to Aircraft, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      registration: 'N137DT',
      rental_cost_dry: 100,
      rental_cost_wet: 150,
      needs_repair: false
    }
  }

  let(:invalid_attributes) {
    {
      registration: 'N137DT',
      rental_cost_dry: -100
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AircraftsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      aircraft = create :aircraft
      get :index, params: { aircraft_model_icao_code: aircraft.icao_code }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      aircraft = create :aircraft
      get :show, params: { id: aircraft.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    let(:aircraft_model) {
      create :aircraft_model, icao_code: 'C172', name: 'Cessna 172 Skyhawk'
    }

    let(:kpit) {
      create :airport, icao_code: 'KPIT'
    }

    let(:kagc) {
      create :airport, icao_code: 'KAGC'
    }

    context "with valid params" do
      let(:params) {
        {
          aircraft_model_icao_code: aircraft_model.icao_code,
          aircraft: valid_attributes.merge({
            home_airport_id: kpit.id,
            current_airport_id: kagc.id
          })
        }
      }

      it "creates a new Aircraft" do
        expect {
          post :create, params: params, session: valid_session
        }.to change(Aircraft, :count).by(1)
      end

      it "renders a JSON response with the new aircraft" do

        post :create, params: params, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(aircraft_url(Aircraft.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new aircraft" do
        params = {
          aircraft_model_icao_code: aircraft_model.icao_code,
          aircraft: invalid_attributes
        }
        post :create, params: params, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          registration: 'N138DT',
          rental_cost_dry: 120,
          rental_cost_wet: 170,
          needs_repair: true
        }
      }

      it "updates the requested aircraft" do
        aircraft = create :aircraft, valid_attributes
        put :update, params: { id: aircraft.to_param, aircraft: new_attributes }, session: valid_session
        aircraft.reload
        expect(aircraft.registration).to eq('N138DT')
        expect(aircraft.rental_cost_dry).to eq(120)
        expect(aircraft.rental_cost_wet).to eq(170)
        expect(aircraft.needs_repair).to be true
      end

      it "renders a JSON response with the aircraft" do
        aircraft = create :aircraft, valid_attributes

        put :update, params: { id: aircraft.to_param, aircraft: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the aircraft" do
        aircraft = create :aircraft, valid_attributes

        put :update, params: { id: aircraft.to_param, aircraft: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested aircraft" do
      aircraft = create :aircraft, valid_attributes
      expect {
        delete :destroy, params: { id: aircraft.to_param }, session: valid_session
      }.to change(Aircraft, :count).by(-1)
    end
  end

end
