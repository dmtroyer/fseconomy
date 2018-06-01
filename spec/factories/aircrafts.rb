FactoryBot.define do
  factory :aircraft do
    registration 'N137DT'
    aircraft_model
    association :current_airport, factory: :airport, icao_code: 'KPIT'
    association :home_airport, factory: :airport, icao_code: 'KAGC'
    rental_cost_dry 100
    rental_cost_wet 150
    needs_repair false
  end
end
