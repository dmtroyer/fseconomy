class AircraftModel < ApplicationRecord
  validates :name, uniqueness: true
  validates :icao_code, uniqueness: true, length: { in: 1..4 }
  validates :mtow, :empty_weight, numericality: { greater_than: 0 }
  validates_presence_of :name, allow_blank: false

  has_many :aircraft

  enum fse_update_frequency: [:never, :hourly, :daily]
  enum fuel_type: [:'100LL', :JetA]

  def useful_load
    mtow - empty_weight
  end

  def to_param
    icao_code
  end
end
