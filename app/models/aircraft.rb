class Aircraft < ApplicationRecord
  validates_presence_of :rental_cost_dry, :needs_repair
  validates :rental_cost_dry, :rental_cost_wet, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :aircraft_model
  belongs_to :current_airport, class_name: 'Airport'
  belongs_to :home_airport, class_name: 'Airport'

  enum equipment_type: [:'IFR/AP/GPS']

  def rentable?
    rental_cost_dry > 0 && !needs_repair
  end
end
