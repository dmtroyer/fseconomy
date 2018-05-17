class AircraftModel < ApplicationRecord
  validates :name, uniqueness: true
  validates_presence_of :name, allow_blank: false

  has_many :aircraft

  enum fuel_type: [:'100LL', :JetA]
end
