class AddIndexOnAircraftModelIcaoCode < ActiveRecord::Migration[5.2]
  def change
    add_index :aircraft_models, :icao_code
  end
end
