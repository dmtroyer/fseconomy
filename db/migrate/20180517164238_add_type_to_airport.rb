class AddTypeToAirport < ActiveRecord::Migration[5.2]
  def change
    add_column :airports, :type, :integer
  end
end
