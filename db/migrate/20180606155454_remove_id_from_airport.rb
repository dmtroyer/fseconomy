class RemoveIdFromAirport < ActiveRecord::Migration[5.2]
  def change
    change_table :airports, primary_key: 'icao_code' do |t|
      t.remove :id
    end
    change_table :aircrafts do |t|
      t.change :current_airport_id, :string
      t.change :home_airport_id, :string
    end
  end
end
