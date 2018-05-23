require 'rails_helper'

RSpec.describe Aircraft, type: :model do
  let(:aircraft) { build :aircraft }

  describe 'validations' do
    it 'must have positive dry rental costs' do
      is_expected.to validate_numericality_of(:rental_cost_dry).is_greater_than_or_equal_to(0)
    end

    it 'must have positive wet rental costs' do
      is_expected.to validate_numericality_of(:rental_cost_wet).is_greater_than_or_equal_to(0)
    end

    it 'must have a needs repair flag' do
      is_expected.to validate_inclusion_of(:needs_repair).in_array([true, false])
    end
  end

  describe 'rentable' do

    it 'is rentable if the dry rental cost is greater than zero, it does not need repairs and is not rented by someone else' do
      aircraft.rental_cost_dry = 1
      aircraft.rental_cost_wet = 0
      aircraft.needs_repair = false
      aircraft.rented_by = nil
      expect(aircraft).to be_rentable
    end

    it 'is rentable if the dry rental cost is greater than zero, it does not need repairs and is not rented by someone else' do
      aircraft.rental_cost_dry = 0
      aircraft.rental_cost_wet = 1
      aircraft.needs_repair = false
      aircraft.rented_by = nil
      expect(aircraft).to be_rentable
    end

    it 'is not rentable if it needs repairs' do
      aircraft.rental_cost_dry = 1
      aircraft.needs_repair = true
      aircraft.rented_by = nil
      expect(aircraft).to_not be_rentable
    end

    it 'is not rentable if it has a zero dry and wet rental cost' do
      aircraft.rental_cost_dry = 0
      aircraft.rental_cost_wet = 0
      aircraft.needs_repair = false
      aircraft.rented_by = nil
      expect(aircraft).to_not be_rentable
    end

    it 'is not rentable if it is rented by someone else' do
      aircraft.rental_cost_dry = 1.0
      aircraft.needs_repair = false
      aircraft.rented_by = 'Jane Doe'
      expect(aircraft).to_not be_rentable
    end

  end

  describe 'associations' do

    it { is_expected.to belong_to(:aircraft_model) }

    it { is_expected.to belong_to(:current_airport).class_name('Airport') }

    it { is_expected.to belong_to(:home_airport).class_name('Airport') }

  end
end
