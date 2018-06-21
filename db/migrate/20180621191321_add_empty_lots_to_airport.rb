class AddEmptyLotsToAirport < ActiveRecord::Migration[5.2]
  def change
    add_column :airports, :empty_lots, :integer
  end
end
