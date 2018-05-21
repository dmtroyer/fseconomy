class ChangeRentalCostToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :aircrafts, :rental_cost_dry, :integer
    change_column :aircrafts, :rental_cost_wet, :integer
  end
end
