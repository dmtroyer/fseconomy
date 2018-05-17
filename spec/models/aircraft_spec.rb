require 'rails_helper'

RSpec.describe Aircraft, type: :model do
  let(:aircraft) { build :aircraft }

  it 'must have rental dry cost' do
    should validate_presence_of(:rental_cost_dry)
  end

  it 'must have a needs repair flag' do
    should validate_presence_of(:needs_repair)
  end

  describe 'associations' do

    it { should belong_to(:aircraft_model) }

    # @TODO need to figure out these relationships
    # it { should belong_to(:current_airport) }

    # it { should belong_to(:home_airport) }

  end
end
