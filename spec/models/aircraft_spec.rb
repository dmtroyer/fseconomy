require 'rails_helper'

RSpec.describe Aircraft, type: :model do
  let(:aircraft) { build :aircraft }

  describe 'validations' do
    it 'must have rental dry cost' do
      should validate_presence_of(:rental_cost_dry)
    end

    it 'must have a needs repair flag' do
      should validate_presence_of(:needs_repair)
    end

    it 'must have positive dry rental costs' do
      should validate_numericality_of(:rental_cost_dry).is_greater_than_or_equal_to(0)
    end

    it 'must have positive wet rental costs' do
      should validate_numericality_of(:rental_cost_wet).is_greater_than_or_equal_to(0)
    end
  end

  describe 'rentable' do

    it 'is rentable if the dry rental cost is greater than zero and it does not need repairs' do
      aircraft.rental_cost_dry = 1.0
      aircraft.needs_repair = false
      expect(aircraft).to be_rentable
    end

    it 'is not rentable if it needs repairs' do
      aircraft.rental_cost_dry = 1.0
      aircraft.needs_repair = true
      expect(aircraft).to_not be_rentable
    end

    it 'is not rentable if it has a zero rental cost' do
      aircraft.rental_cost_dry = 0.0
      aircraft.needs_repair = false
      expect(aircraft).to_not be_rentable
    end

  end

  describe 'associations' do

    it { should belong_to(:aircraft_model) }

    # @TODO need to figure out these relationships
    # it { should belong_to(:current_airport) }

    # it { should belong_to(:home_airport) }

  end
end
