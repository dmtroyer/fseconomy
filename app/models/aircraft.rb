class Aircraft < ApplicationRecord
  validates :rental_cost_dry, :rental_cost_wet, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :aircraft_model
  belongs_to :current_airport, class_name: 'Airport', optional: true
  belongs_to :home_airport, class_name: 'Airport'

  scope :for_sale, -> { where('sale_price > 10').order(:sale_price) }

  def equipment
    equipment = has_ifr_equipment ? 'IFR' : 'VFR'
    equipment += '/AP' if has_autopilot
    equipment += '/GPS' if has_gps
    equipment
  end

  def icao_code
    aircraft_model.icao_code
  end

  def total_sale_price
    sale_price + fees_owed
  end

  def rentable?
    (rental_cost_dry > 0 || rental_cost_wet > 0) && !needs_repair && !rented_by
  end
end
