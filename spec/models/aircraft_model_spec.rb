require 'rails_helper'

RSpec.describe AircraftModel, type: :model do
  let(:aircraft_model) { build :aircraft_model }

  describe 'name' do

    it 'must be present' do
      should validate_presence_of(:name)
    end

    it 'cannot be blank' do
      aircraft_model.name = ''
      expect(aircraft_model).to_not be_valid
    end

    it 'must be unique' do
      # This validate_uniqueness_of matcher needs a record in the database
      create :aircraft_model
      should validate_uniqueness_of(:name)
    end

  end

  describe 'fuel_type' do
    it 'has the enums' do
      should define_enum_for(:fuel_type).with([:'100LL', :JetA])
    end
  end

  describe 'associations' do
    it { should have_many(:aircraft) }
  end
end
