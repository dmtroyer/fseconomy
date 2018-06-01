class RemoveSerialNumberFromAircraft < ActiveRecord::Migration[5.2]
  def change
    remove_index :aircrafts, :serial_number
    remove_column :aircrafts, :serial_number, :integer
  end
end
