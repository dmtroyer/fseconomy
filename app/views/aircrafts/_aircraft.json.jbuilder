attributes = [:id, :registration, :owner, :current_airport_id, :home_airport_id,
              :rental_cost_dry, :rental_cost_wet, :needs_repair]
json.(aircraft, *attributes)
json.rentable aircraft.rentable?
