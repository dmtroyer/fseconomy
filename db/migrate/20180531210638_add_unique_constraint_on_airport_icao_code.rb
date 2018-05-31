class AddUniqueConstraintOnAirportIcaoCode < ActiveRecord::Migration[5.2]
  def change
    remove_index :airports, :icao_code
    add_index :airports, :icao_code, unique: true
  end
end
