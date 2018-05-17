FactoryBot.define do
  factory :aircraft do
    serial_number 1
    registration "N137DT"
    aircraft_model
    rental_cost_dry "100.00"
    needs_repair false
  end
end
