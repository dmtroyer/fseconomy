class ChangeEquipmentOnAircraft < ActiveRecord::Migration[5.2]
  def change
    remove_column :aircrafts, :equipment_type, :integer
    add_column :aircrafts, :has_ifr_equipment, :boolean, default: false
    add_column :aircrafts, :has_autopilot, :boolean, default: false
    add_column :aircrafts, :has_gps, :boolean, default: false
  end
end
