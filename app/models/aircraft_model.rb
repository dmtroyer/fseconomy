class AircraftModel < ApplicationRecord
  validates :name, uniqueness: true
  validates :icao_code, uniqueness: true, length: { in: 1..4 }
  validates_presence_of :name, allow_blank: false

  has_many :aircraft

  enum fuel_type: [:'100LL', :JetA]

  def to_param
    icao_code
  end
end
