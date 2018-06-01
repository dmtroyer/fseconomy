class Airport < ApplicationRecord
  alias_attribute :latitude, :lat
  alias_attribute :longitude, :lng

  validates :icao_code, uniqueness: true, length: { in: 1..4 }

  has_many :current_aircraft, class_name: 'Aircraft', inverse_of: 'current_airport'
  has_many :home_aircraft, class_name: 'Aircraft', inverse_of: 'home_airport'

  enum airport_type: [:civil, :military, :water]
end
