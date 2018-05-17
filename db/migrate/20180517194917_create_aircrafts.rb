class CreateAircrafts < ActiveRecord::Migration[5.2]
  def change
    create_table :aircrafts do |t|
      t.integer :serial_number
      t.string :registration
      t.belongs_to :aircraft_model
      t.string :owner
      t.references :current_airport
      t.references :home_airport
      t.decimal :sale_price
      t.integer :equipment_type
      t.decimal :rental_cost_dry
      t.decimal :rental_cost_wet
      t.integer :bonus
      t.integer :rental_time
      t.string :rented_by
      t.decimal :fuel_pct
      t.boolean :needs_repair
      t.integer :airframe_time
      t.integer :engine_time
      t.integer :time_last_100hr

      t.timestamps
    end

    add_index :aircrafts, :serial_number
  end
end
