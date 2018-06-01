class ChangeAirportType < ActiveRecord::Migration[5.2]
  def change
    rename_column :airports, :type, :airport_type
  end
end
