FactoryBot.define do
  factory :aircraft_model do
    name "Cessna 172 Skyhawk"
    additional_crew 0
    seats 4
    passengers 3
    cruise_speed 100
    num_engines 1
    gph 8
    fuel_volume 54
    payload 432
    endurance_distance "680.0"
    endurance_hours "6.8"
    cost_per_nm "0.35"
    mtow 1180
    empty_weight 748
    base_price "72600.00"
  end
end
