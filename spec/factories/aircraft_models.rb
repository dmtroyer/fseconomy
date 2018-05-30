FactoryBot.define do
  factory :aircraft_model do
    name "Cessna 172 Skyhawk"
    icao_code "C172"
    additional_crew 0
    seats 4
    cruise_speed 100
    num_engines 1
    gph 8
    fuel_volume 54
    mtow 1180
    empty_weight 748
    base_price 72600.00
  end
end
