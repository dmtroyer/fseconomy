# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


if Rails.env.development?
  KVBW = Airport.find_or_initialize_by(name: 'Bridgewater Airpark', icao_code: 'KVBW')
  C172 = AircraftModel.find_or_initialize_by(name: 'Cessna 172 Skyhawk', icao_code: 'C172')
  Aircraft.create! do |aircraft|
    aircraft.registration = 'N137DT'
    aircraft.aircraft_model = C172
    aircraft.home_airport = KVBW
    aircraft.current_airport = KVBW
    aircraft.needs_repair = false
    aircraft.rental_cost_dry = 100
    aircraft.rental_cost_wet = 200
  end
end
