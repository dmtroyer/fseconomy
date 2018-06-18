class AddFeesToAircraft < ActiveRecord::Migration[5.2]
  def change
    add_column :aircrafts, :fees_owed, :decimal
  end
end
