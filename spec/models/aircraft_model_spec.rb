require 'rails_helper'

RSpec.describe AircraftModel, type: :model do
  let(:aircraft_model) { build :aircraft_model }

  describe 'icao code' do
    it 'must be between 1 and 4 characters' do
      is_expected.to validate_length_of(:icao_code).is_at_least(1).is_at_most(4)
    end

    it 'cannot be null' do
      aircraft_model.icao_code = nil
      expect(aircraft_model).to_not be_valid
    end

    it 'must be unique' do
      # This validate_uniqueness_of matcher needs a record in the database
      create :aircraft_model
      is_expected.to validate_uniqueness_of(:icao_code)
    end
  end

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
