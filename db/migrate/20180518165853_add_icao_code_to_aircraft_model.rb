class AddIcaoCodeToAircraftModel < ActiveRecord::Migration[5.2]
  def change
    add_column :aircraft_models, :icao_code, :string, limit: 4, null:false, index: true
  end
end
