class TrimAircraftModelFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :aircraft_models, :passengers, :integer
    remove_column :aircraft_models, :payload, :integer
    remove_column :aircraft_models, :endurance_distance, :decimal
    remove_column :aircraft_models, :endurance_hours, :decimal
    remove_column :aircraft_models, :cost_per_nm, :decimal
    add_column :aircraft_models, :engine_price, :decimal
  end
end
