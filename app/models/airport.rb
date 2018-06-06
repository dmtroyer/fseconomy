class Airport < ApplicationRecord
  self.primary_key = 'icao_code'

  alias_attribute :latitude, :lat
  alias_attribute :longitude, :lng

  validates :icao_code, uniqueness: true, length: { in: 1..4 }

  has_many :current_aircraft, class_name: 'Aircraft', foreign_key: 'current_airport_id'
  has_many :home_aircraft, class_name: 'Aircraft', foreign_key: 'home_airport_id'

  enum airport_type: [:civil, :military, :water]
end
