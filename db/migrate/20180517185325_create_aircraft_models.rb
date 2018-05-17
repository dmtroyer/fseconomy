class CreateAircraftModels < ActiveRecord::Migration[5.2]
  def change
    create_table :aircraft_models do |t|
      t.string :name, null: false
      t.integer :additional_crew
      t.integer :seats
      t.integer :passengers
      t.integer :cruise_speed
      t.integer :num_engines
      t.integer :gph
      t.integer :fuel_volume
      t.integer :fuel_type
      t.integer :payload
      t.decimal :endurance_distance
      t.decimal :endurance_hours
      t.decimal :cost_per_nm
      t.integer :mtow
      t.integer :empty_weight
      t.decimal :base_price
      t.datetime :last_fse_update

      t.timestamps
    end
    add_index :aircraft_models, :name
  end
end
