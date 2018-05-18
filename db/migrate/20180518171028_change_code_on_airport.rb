class ChangeCodeOnAirport < ActiveRecord::Migration[5.2]
  def change
    rename_column :airports, :code, :icao_code
  end
end
