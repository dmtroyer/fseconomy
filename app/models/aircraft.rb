class Aircraft < ApplicationRecord
  validates :rental_cost_dry, :rental_cost_wet, numericality: { greater_than_or_equal_to: 0 }
  validates_inclusion_of :needs_repair, in: [true, false]

  belongs_to :aircraft_model
  belongs_to :current_airport, class_name: 'Airport'
  belongs_to :home_airport, class_name: 'Airport'

  def rentable?
    rental_cost_dry > 0 && !needs_repair && !rented_by
  end
end
