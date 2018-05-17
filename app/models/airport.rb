class Airport < ApplicationRecord
  alias_attribute :latitude, :lat
  alias_attribute :longitude, :lng
end
