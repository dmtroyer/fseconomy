require 'rails_helper'

RSpec.describe Airport, type: :model do
  describe 'code' do
    let(:airport) { build :airport }

    it 'can be 1 to 4 characters' do
      airport.code = '1234'
      expect(airport).to be_valid
      airport.code = '1'
      expect(airport).to be_valid
    end

    it 'cannot be more than 4 characters' do
      airport.code = '12345'
      expect(airport).to_not be_valid
    end

    it 'cannot be null' do
      airport.code = nil
      expect(airport).to_not be_valid
    end

    it 'must be unique' do
      airport.code = 'KPIT'
      airport.save

      expect {
        create :airport, code: 'KPIT'
      }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Code has already been taken")
    end
  end
end
