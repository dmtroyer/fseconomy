class Airport < ApplicationRecord
  alias_attribute :latitude, :lat
  alias_attribute :longitude, :lng

  enum type: [:civil, :military, :water]

  validates :code, uniqueness: true, length: { in: 1..4 }
end
