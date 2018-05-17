class Aircraft < ApplicationRecord
  validates_presence_of :rental_cost_dry, :needs_repair

  belongs_to :aircraft_model
  belongs_to :current_airport, class_name: 'Airport'
  belongs_to :home_airport, class_name: 'Airport'

  enum equipment_type: [:'IFR/AP/GPS']
end
