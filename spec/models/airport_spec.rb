require 'rails_helper'

RSpec.describe Airport, type: :model do
  let(:airport) { build :airport }

  describe 'code' do
    it 'must be between 1 and 4 characters' do
      is_expected.to validate_length_of(:code).is_at_least(1).is_at_most(4)
    end

    it 'cannot be null' do
      airport.code = nil
      expect(airport).to_not be_valid
    end

    it 'must be unique' do
      # This validate_uniqueness_of matcher needs a record in the database
      create :airport
      is_expected.to validate_uniqueness_of(:code)
    end
  end

  describe 'type' do
    it 'has the enums' do
      is_expected.to define_enum_for(:type).with([:civil, :military, :water])
    end
  end

  describe 'associations' do
    it do
      is_expected.to have_many(:current_aircraft)
                     .class_name('Aircraft')
                     .inverse_of('current_airport')
    end
  end
end
