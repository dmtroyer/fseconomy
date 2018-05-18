require 'rails_helper'

RSpec.describe AircraftModel, type: :model do
  let(:aircraft_model) { build :aircraft_model }

  describe 'name' do

    it { is_expected.to validate_presence_of(:name) }

    it 'cannot be blank' do
      aircraft_model.name = ''
      expect(aircraft_model).to_not be_valid
    end

    it 'must be unique' do
      # This validate_uniqueness_of matcher needs a record in the database
      create :aircraft_model
      is_expected.to validate_uniqueness_of(:name)
    end

  end

  describe 'fuel_type' do
    it { is_expected.to define_enum_for(:fuel_type).with([:'100LL', :JetA]) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:aircraft) }
  end
end
